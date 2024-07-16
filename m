Return-Path: <linux-kernel+bounces-253821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD6932779
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5576281746
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1919B3E3;
	Tue, 16 Jul 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="pwMYZyNE"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0317CA05
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136507; cv=none; b=Fmj93pLnMunlpYT1HQM8yJBp92vmJ6RwHVf5osoZnq/bFjmTnu76y9S2Ld1Pxevt7mukHJSnXWhYOvaqTorHxJdGrms9DlcHxyTHiRuqhydkd0rBGxls4rEFNd8tJr9tRPnij3l4BRVVEMiov+7lJcD59S7OLknPCXNCEOLQXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136507; c=relaxed/simple;
	bh=76d7vTt4ydPuANqnXtArwsFZACyV4lRlNG/dbYXT1es=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GI2LA5oKmI9WP8aiwd9TfaUdmfyqckghyPoEd7+A6DxrolRcG+7QpypmFdhKYLBo5A9KbUMpv5luiqcdoDXr1Npped5egKdyxoQWpUGny0uelXXF6FxVtRxDtvRpNqcBrdlDMVzvsPUvjngePYcicy8mHLhQQJ4N50i4bqQfpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=pwMYZyNE; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d6301e7279so3563134b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1721136503; x=1721741303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5Y3DFMUkca+3aGGLe2U7TcM6m5w8dx7JTp0lKK2DxI=;
        b=pwMYZyNEMb3LSa3yMaYIKE4CbCgI3ZD8vKWhlVwhOv2xWZce0XNxUj2lrKcP/U4Hrr
         mrZNKMhzfETguYGtTFkmqVaR22awguB8xIKYi47PnNlAr+RXuEjrla4EbkPEhMz8yPNS
         Rw0SqhwHLFw9YQVNO9gmRygBCiocukhYRzPRxkqbovneAmspXp/qLbfs9JKprTOglG2N
         gemVpJDtkTdRADqoTiKWxObwLDCyeapJwTz7VWaMsTxxLzISCSSkfo8yapuKMdncpd39
         KBtJCN1IrbQE1rflgVC9ZvddISThxlh0irBWxTqbvJjyyiwuujobjfdiqa6Oxd5ZtWgz
         xiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136503; x=1721741303;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5Y3DFMUkca+3aGGLe2U7TcM6m5w8dx7JTp0lKK2DxI=;
        b=fxQd+6fthADj119dssdphlPNdx1UqpWedAhcAOIGotVPdRfHSIqBPs+BptkpJQM92M
         moQv3pYva/5K3+MaR5X4SWl2OdwktMGMAyVEZBD4tXTaHMMDfMQyGeTy7e+ze192Hveq
         nUwe4M6iXkHHgWK1sTBhzAWuzlI2x3rRnI6crz82C5wMJG5u3qPT5nbWb7pULui6SvnS
         QXzuV4mytQKAKU9aBnNNT5e/tAoKOko5agj1pBpkiPNcpNHKwLQlQ1qg4X7/vJe5j49b
         Zt2G9K+ESmolW8bVwcK61F6ZstHQRaUZF1MjS9oKtjZChcPd2ZCvvKEWaDbHQUddS3XH
         zMHQ==
X-Gm-Message-State: AOJu0YzXWlBCIjn3CHs55kys2d0YqiXBs+UA0iANUtUCr/giqUrjJocA
	4056a+WAB6hxh48LJ+sKnE60P4Qp5uSt3PjjiXcr9gSItSLuyJ2uZHjx96KA04E=
X-Google-Smtp-Source: AGHT+IE4nb+3a/pjodL0fJ7V33V1h/9FHB9Msgn1dowW0UJWXLG6hD1+mnuaIoyFvSnmLQTFPWn+uQ==
X-Received: by 2002:a05:6808:3a12:b0:3d9:2626:c64a with SMTP id 5614622812f47-3dac7b8c175mr3372280b6e.18.1721136503518;
        Tue, 16 Jul 2024 06:28:23 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8570:9c29:577f:abfb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dabc056869sm802192b6e.4.2024.07.16.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:28:23 -0700 (PDT)
Date: Tue, 16 Jul 2024 08:28:21 -0500
From: Corey Minyard <corey@minyard.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.11
Message-ID: <ZpZ1dVeLWUbAd89V@mail.minyard.net>
Reply-To: corey@minyard.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 0cac73eb3875f6ecb6105e533218dba1868d04c9:

  Merge tag 'pm-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2024-06-14 09:52:51 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.11-1

for you to fetch changes up to 19a01155ddfe525e3a4e7cef734f18cce640b1ef:

  ipmi: Drop explicit initialization of struct i2c_device_id::driver_data to 0 (2024-07-08 15:05:18 -0500)

----------------------------------------------------------------
IPMI: Small updates and fixes

Some cleanups for device changes coming, and some range checks on data
coming from a host to a BMC.

----------------------------------------------------------------
Dan Carpenter (1):
      ipmi: ssif_bmc: prevent integer overflow on 32bit systems

Uwe Kleine-König (1):
      ipmi: Drop explicit initialization of struct i2c_device_id::driver_data to 0

 drivers/char/ipmi/ipmb_dev_int.c |  4 ++--
 drivers/char/ipmi/ipmi_ipmb.c    |  4 ++--
 drivers/char/ipmi/ipmi_ssif.c    |  2 +-
 drivers/char/ipmi/ssif_bmc.c     | 10 ++++++----
 4 files changed, 11 insertions(+), 9 deletions(-)


