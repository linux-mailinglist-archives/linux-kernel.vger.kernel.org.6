Return-Path: <linux-kernel+bounces-331432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4F97ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2671C2108F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE1157A7C;
	Tue, 17 Sep 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPRxXVyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBA15AF6;
	Tue, 17 Sep 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561832; cv=none; b=LHxqvLUb79cgSb8/Q88gNQYgl4q+G+8up4Ouys/G6xu1TjKzYlWOZXNg4lzR7lb22rZlYsHStYrBdNUytt5Tc9Evc9eoVIIX1vcYh2tWacIf2Jfaq9QHYGWUy/eWGgkZsgKi2tjKCS8TIcs/vK57Qyfv6gwL1awZV6OYKkoyPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561832; c=relaxed/simple;
	bh=vilMTGZcXF6i1znoYdW1DfhTTmW+PiKswocbh2AUG7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3PP3p1YPFqOZJRMfXZSTGi0yTVQxaj6d33pOHhIVkE/+QYpnNoGeyq6KnTURa1zu7uZI2irWtl6PutcDgHAf0IyhdRTBuPX03ptlAXDsPCf3aCrmu4RGk2d2wdldvOslCiO6XIMuPBEoNG4XTtpoynuM37nHU816vtTlyt5iHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPRxXVyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0480C4CEC6;
	Tue, 17 Sep 2024 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726561832;
	bh=vilMTGZcXF6i1znoYdW1DfhTTmW+PiKswocbh2AUG7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPRxXVycUMCvn8ysa1WAvsU4MoONBGJ5DFinQAj8jL4QWgCPGT4YAjatmj1XQLjC0
	 1aU0ZBc2erwcT3j2B7RAXXrQPmaJ4/rzdQOu+ws7QN28jYWMIprlBg5UeM3HqDEqsc
	 UoPugIcMQQNBwYgFogO9fCBnjixmtFJ8ioffdDqtb1ZRTYBnES9KHJ+K1tDCHdTp5J
	 XWwVvx4+TasXMlzNDtezwu2kE8YDvMW2z/0PgdDL+PuQkVVmtyZ02g6/7SPYAJW+8Y
	 zot3dZ+wwERKzrYMa8kJ+gmw8uMa+S1SISpFf70ovcAAm3YXr/N8fhfQke1+a2cisL
	 6RCqcNCqQHKXw==
Date: Tue, 17 Sep 2024 01:30:32 -0700
From: Kees Cook <kees@kernel.org>
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: gregkh@linuxfoundation.org, m.grzeschik@pengutronix.de,
	quic_jjohnson@quicinc.com, gustavoars@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: prefer strscpy() over strcpy()
Message-ID: <202409170130.C9F169D4@keescook>
References: <20240914231756.503521-1-abdul.rahim.ref@myyahoo.com>
 <20240914231756.503521-1-abdul.rahim@myyahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914231756.503521-1-abdul.rahim@myyahoo.com>

On Sun, Sep 15, 2024 at 04:47:49AM +0530, Abdul Rahim wrote:
> The function strcpy() is depreciated and potentially unsafe. It performs
> no bounds checking on the destination buffer. This could result in
> linear overflows beyond the end of the buffer, leading to all kinds of
> misbehaviors. The safe replacement is strscpy() [1].
> 
> this fixes checkpatch warning:
>     WARNING: Prefer strscpy over strcpy
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>

Yup, these look good. Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

