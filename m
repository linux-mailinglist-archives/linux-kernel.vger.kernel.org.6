Return-Path: <linux-kernel+bounces-412010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A879D0258
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A941F22D01
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4254782;
	Sun, 17 Nov 2024 07:33:42 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924152C95
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731828822; cv=none; b=m6kV32KoVKHxOIaMOU+gDBIFix/hH8Ov7maDHvam6ZOKn6UkdqJ++1ax/qkSqVNYAhRAwbmLqm487Ik440frWqeBhqumrcDyAc8S4+LaoJwN3TFwQfcN8r6k6rErUawZTuzI0U76KsDR/NSZHnG/02H1bs1dH/Nj5gUvVDRffmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731828822; c=relaxed/simple;
	bh=QE5HpRlfZPD7nD/qiKO/hgmRaCB49b3+TQJFWEik8zQ=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=LdcFRmTCY7MH5ZhRARLyWrBFtWP/eXj89/2hZGEC267FaDxrdzUvxxxsZzmfT1mTfKMEdz3BEzONhHiu5ZQRBfNk7hvCOE1oWrZiGcfd7xssDCYbAQngDfkwMV2/ZvDAZ5DCwCC9tKi26W3XTTDyhddvaMIJdffcZS/4iUuq5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCZmq-005BiM-R3
	for linux-kernel@vger.kernel.org;
	Sun, 17 Nov 2024 08:33:38 +0100
Received: from 1-175-135-24.dynamic-ip.hinet.net ([1.175.135.24] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCZmk-005Bi1-Kb;
	Sun, 17 Nov 2024 08:33:30 +0100
Message-ID: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
Subject: Highly critical bug in XHCI Controller
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 17 Nov 2024 15:33:28 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: linuxusb.ml@sundtek.de
X-SA-Exim-Scanned: No (on sundtek.de); SAEximRunCond expanded to false

Hi,


the issue was first reported at vdr-portal.de
https://www-vdr--portal-de.translate.goog/forum/index.php?thread/136541-emp=
fehlung-dvb-s2-tuner-oder-satip/&postID=3D1376196&_x_tr_sl=3Dde&_x_tr_tl=3D=
en&_x_tr_hl=3Dde&_x_tr_pto=3Dwapp#post1376196

we've got around a highly critical bug in the xhci driver.

https://sundtek.de/support/uxvd32.txt

In xhci.c

The bug is still active in Mainline:
https://github.com/torvalds/linux/blob/master/drivers/usb/host/xhci.c#L2382

static int xhci_check_bw_table(struct xhci_hcd *xhci,
        struct xhci_virt_device *virt_dev,
        int old_active_eps)

bw_table can end up with a NULL pointer.

This problem will lead to a complete kernel crash, rendering the entire
system unusable without any access to the actual linux system.

How to trigger the problem?
Short D+/D- or pull them to ground on a USB device while connecting the
device.

The problem can happen due to following cases:
* a device is getting suddenly disconnected during enumeration
* a faulty cable
* a faulty device=20
* a malicious device triggers this issue on purpose
* if there are electrical issues during connecting a device.

A quick hotfix would be to check if bw_table is NULL in
xhci_check_bw_table, however the check should be performed earlier - in
the area where bw_table is supposed to be assigned.

Best Regards,
Markus

