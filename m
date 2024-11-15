Return-Path: <linux-kernel+bounces-411004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE29CF326
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E26BB362E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B771D5157;
	Fri, 15 Nov 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Sjn+qhmh"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96018E047;
	Fri, 15 Nov 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688442; cv=none; b=HcmBbTUh5g8LqsHsq1hY59n1RS03Hv9ZJPPccw7ixngQslWY7qOPCW6kfCQUQTfRgnnce70oKKGdgwVoVsZUJ0qf+E+X3H9HlG2r/+HBTqVvwqC2YWZ2UdBBo6S8DjGDzkacr/YpUd7nXbq0EKszHlQfDHyV9h0NpfeIXqqyQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688442; c=relaxed/simple;
	bh=EGdVkBicn6D66qIugbfFwGPESvPj0kk8Mw7IQ5GEbpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/GagURf9mQ0eWq5gUiBeebplXaKZ8Dt5uXaYIw8Erm5jENsa1PrTSr519XDioTaMitYZD4XCPIYPkbo9j4PtXk6Vhk+P7Lsz2lOH35AduINI5UlMCigJrjdaWTRT/3wI3kUWy1CQozi8wzbRhnjvqoY1RHxxGuo5yhDsS15K9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Sjn+qhmh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731688425;
	bh=EGdVkBicn6D66qIugbfFwGPESvPj0kk8Mw7IQ5GEbpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sjn+qhmhGOD764rMI/myX1+sL9T9oDHvUnukT1x4QLD0LxEx0j/5WH0kN2iBKMSVa
	 OfYqu+T/Su3Cg+O4kcpHubf2cIg5D3c4iuWcxnhGHcGfMMmWQJ77cYWR6GRgk/Gl/L
	 tiZtGxraOCgC1Jp723XVdO6PBLllB18oNemT+AYU=
Date: Fri, 15 Nov 2024 17:33:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <dc879ed8-a8be-48c5-a4f3-18f09d3cbfb2@t-8ch.de>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>

On 2024-11-15 08:31:27-0800, Guenter Roeck wrote:
> Hi Thomas,
> 
> On Wed, Nov 13, 2024 at 05:39:16AM +0100, Thomas Weißschuh wrote:
> > Using an #ifdef in a C source files to have different definitions
> > of the same symbol makes the code harder to read and understand.
> > Furthermore it makes it harder to test compilation of the different
> > branches.
> > 
> > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > conditional.
> > The resulting binary is still the same as before as the compiler
> > optimizes away all the unused code and definitions.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> 
> I decided to apply the patch despite my concerns about the lack
> of dummy functions. Let's see if it blows up in our face; if so,
> I'll revert it.

It will blow up because of the missing declaration/stub for
thermal_zone_device_update()


Thomas

