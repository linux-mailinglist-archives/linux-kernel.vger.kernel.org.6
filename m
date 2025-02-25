Return-Path: <linux-kernel+bounces-532300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2898A44B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5CE3B52C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463E19F462;
	Tue, 25 Feb 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="krA8TjA6"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB671547F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740511242; cv=none; b=MVfz2bv5lt8cnV7CuzeGWcpIBi5hIh4HeE7BG8CVG/mAbML5CGsg6vUDHrULTmpeqW0gH+x2fPm0mROdMI2FAJAt+jmxzn7EWzyBm+t496jTKSC61Awl+5znURS91XDisv8P4fzfTF3FNOxD2z7AaTKtbQgd5CM2wonmvT8/vhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740511242; c=relaxed/simple;
	bh=RADfpvUUB5xFjExltzb59CSi/mP9Xc1qO4lVRwRt8dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S67h8FwhST0XDljiPdw9nm9SaK//HgH4uHs5qST5CiVJarJy77dtfvm6dBqeE0NX2r9GqlgqB0Emj8pmf3roOyb2O5VLA357iEQ7S/Rvpxqx6Te8KNig+oe9yGNa0RTPrIJboThN6kvIuqEN8J2Z5u7Z64+j0eGVWDrUo+RdZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=krA8TjA6; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6295AC000C81;
	Tue, 25 Feb 2025 11:14:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6295AC000C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1740510841;
	bh=RADfpvUUB5xFjExltzb59CSi/mP9Xc1qO4lVRwRt8dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krA8TjA69/CRBGoui6S/gmek/sjssohgRONExdUPhJj/kfwSQV7FiPQtX79PZzCPo
	 jOVjq1x4AIZOySyVl0dJ+tO2AIW8+2BExcaSKh/N9YC86WqWkXDzgZ6Q7hMu40yN25
	 pIEE7iEE58I6gRCZdsTGp3v4uxxhznvxPKBi8jMY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 0A2B218041CCB8;
	Tue, 25 Feb 2025 11:14:01 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	florian.fainelli@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] bus: brcmstb_gisb: use dev_groups to register attribute groups
Date: Tue, 25 Feb 2025 11:14:00 -0800
Message-ID: <20250225191400.1059513-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224193730.2698894-1-ovidiu.panait.oss@gmail.com>
References: <20250224193730.2698894-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Mon, 24 Feb 2025 21:37:30 +0200, Ovidiu Panait <ovidiu.panait.oss@gmail.com> wrote:
> Instead of manually adding attribute groups, set dev_groups pointer to
> have the driver core do it.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian

