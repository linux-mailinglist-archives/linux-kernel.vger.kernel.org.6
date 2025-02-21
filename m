Return-Path: <linux-kernel+bounces-525054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC66A3EA40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948AF1776A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF50146A68;
	Fri, 21 Feb 2025 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O82wkX04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25378F52;
	Fri, 21 Feb 2025 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102106; cv=none; b=NxsV73+Ac8TGeeMMQOmfEyx05miZHE0x/1maypbsOcK9kX6FD3MkhrRBP12C2OOgy+xudTiBAATg9mEPRQ0mJYiuzt9O2LOy/A41ecf5P7FLrMfwh5vz/jp2P3efJe4A2fg+Diy3UZarqFxlTOt9r+2X+HMkXFPk75gXk5znbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102106; c=relaxed/simple;
	bh=ViIZ0tHfFjauVtWx3ImK+yTR7M7kKjp9seXzk+6u76U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/A5TFJplko9Y77EluEa2DMjj5JtshNgBTXq8w9wXJWjyGvx40naUz6+9K7Es5DYIaJYSA0u1yrAIB7seOT3kfdb46WMa36C3E/Ei6AYc2xJPB0OtX7E3OyYl4yiFWwWjHC3CctEb4krk1d+k91gM5jY5Ik22GfxPNFULqDY8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O82wkX04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B84C4CED1;
	Fri, 21 Feb 2025 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102106;
	bh=ViIZ0tHfFjauVtWx3ImK+yTR7M7kKjp9seXzk+6u76U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O82wkX04zJh+EnsIC3PVIawS4834xBqOGtVJ8CgULdt/oG5uiTz/izgmLdjJmCLe4
	 fX+tMkdEESYzOw9TkTa3Y8V1gEADmB04+91eodSDBTNouin2BgAbGsyq0zszNEZ8G1
	 y48tiaeytzJAgE6Vv0NImxz4JTNY4ZYU3NTLLASXK3CZuYYiA9f/o4yMCZ6akATjyY
	 Ywf4RHf87YfzX/prBHbjqA91cWuk93wCzB+I3WuELqBk5TzMYiKHG6UxRzY6fQm2Ln
	 184O+flK5Wr1KNl/hFuHjjQ9uxUGr5ZJF17ZkqJXe0pDjJk0HgFnwYqaREaIjakWOP
	 /ZeDKygu4q3Rw==
Date: Fri, 21 Feb 2025 01:41:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev, Jameson Thies <jthies@google.com>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add support for setting
 USB mode via sysfs
Message-ID: <Z7fZ1vpb02fn0YoG@google.com>
References: <20250210130419.4110130-1-akuchynski@chromium.org>
 <Z7SYg8HaSVx9QyH9@tzungbi-laptop>
 <CAMMMRMfYWqGEJDmMaPQFjQFeUhWJ4wVp-xy2TTdAhp3gRv-n8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMMRMfYWqGEJDmMaPQFjQFeUhWJ4wVp-xy2TTdAhp3gRv-n8g@mail.gmail.com>

On Thu, Feb 20, 2025 at 01:39:57PM +0000, Andrei Kuchynski wrote:
> On Tue, Feb 18, 2025 at 2:26 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2025 at 01:04:19PM +0000, Andrei Kuchynski wrote:
> > > +static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode mode)
> > > +{
> > > +     struct cros_typec_port *port = typec_get_drvdata(tc_port);
> > > +     struct ec_params_typec_control req = {
> > > +             .port = port->port_num,
> > > +             .command = (mode == USB_MODE_USB4) ?
> > > +                     TYPEC_CONTROL_COMMAND_ENTER_MODE : TYPEC_CONTROL_COMMAND_EXIT_MODES,
> > > +             .mode_to_enter = CROS_EC_ALTMODE_USB4
> >
> > The symbol `CROS_EC_ALTMODE_USB4` doesn't exist.  On a related note, wouldn't
> > it always enter CROS_EC_ALTMODE_USB4 if the value is hard-coded here?
> >
> 
> CROS_EC_ALTMODE_USB4 is defined in drivers/platform/chrome/cros_ec_typec.h.

I see.  Overlooked that.

