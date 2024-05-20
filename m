Return-Path: <linux-kernel+bounces-183563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72E8C9AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49560B22008
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32294653C;
	Mon, 20 May 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai3w3hmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB246426;
	Mon, 20 May 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198409; cv=none; b=NYUVOdlS9fn3UlaQ4kCNiUJl0dtJ2fLjz9vINLbQc2QdpfjdqKAn5C3cfd/li2RSezdNBImrPlcQexC0lcg04y8tPiwrs4EnNVBEXpUdlArV0XlPGOiyDW8b8cZQawww3nXEKm8FfaBHBgeAHqs25FGKEfP+a3ReCVLWHVMeKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198409; c=relaxed/simple;
	bh=ngGzKQovEqZCQRCuA0UQM97qY9IEl28WOJ1T6pBDXek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX/08JQuAGgXQ07NBwnZ1nZQJ4+M83oSeXkioFzd8XGsaDHFeCpm+eMBTI0ENa0N8bktW+b+6VzFcGqF4tScFQNYNpwS31vx77+6MVUugKolmYoKx06CPQfySTRFIVvIqjkGy9+SRx0DfTssxRAs+e7tJ3byBriE8Z+ffJ78Lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai3w3hmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A14C2BD10;
	Mon, 20 May 2024 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198408;
	bh=ngGzKQovEqZCQRCuA0UQM97qY9IEl28WOJ1T6pBDXek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ai3w3hmY0y10iaceQjxFM4LCSfzaAW3O28X+9WHEl2OS+1up1JeC4PJ+p7lnHuMiN
	 EYGnl22YjmlMKGTOHQ/Oa6I07l9jlxAumI5t8vy7sWYvALxskDgS6plOKZtDzw1wXs
	 NsZO8TZWNvEXIUJSlbu4ZyDPu67cHSx8Z1QGfwykXtYNsfMhkCikSd/mUThwM4d4Gr
	 xStJrZ0Ji4oBdRQ7zGVze6vG9axvlW9RG0acoA4DoKYH7Zxy1bWONdNvDkUIcft3zv
	 AjJDGHMarSgAVZDX0ZAtWvr7jV02CrD0W01eHBTJGMGxfXsksadO3tfIBhcMJDuh4B
	 TFZLwSQ8+Fk9g==
Date: Mon, 20 May 2024 17:46:45 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] platform/chrome: cros_ec_lpc: Pass driver_data in
 static variable
Message-ID: <ZkscBbImKiLJxaBn@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-4-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515055631.5775-4-ben@jubnut.com>

On Wed, May 15, 2024 at 06:56:28AM +0100, Ben Walsh wrote:
> The module init passed extra data to the driver via the driver_data of
> a new platform device. But when an ACPI device already existed, no
> platform device was created, so this extra data wasn't passed to the
> driver.
> 
> Stop using the driver_data and use a static variable instead.

Could it be possible to put the driver data in the acpi_device_id and
somewhere calls acpi_device_get_match_data()?

