Return-Path: <linux-kernel+bounces-228324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FE915E20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37C81C22593
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73295145A05;
	Tue, 25 Jun 2024 05:27:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A4143C67
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293251; cv=none; b=WThzNRf+u3qhbDVSjczq8aR8gmQ5/NkC8HAif6c6kFYVAum3tNXM2BYorAxgn0pqk5D5ItOEDTM8St84JqKCKItbtzj7R9Rgpk2cUPIK9QI1LS0i9vcaMcV9IQcF7/nvkFkl3Fy8aN54bGvA02+KoJxLbld4aDdFOIhCVUqQDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293251; c=relaxed/simple;
	bh=RJaoHogdW2Mu9NHiautEPTgzcoZh6vSn0WgabcVsHn4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y59+TLs0TxiuwFkPMpDz2of0XS4+CFS4N8EZeCZ4n44El29t+oNRjJLgygFM01qg0flSzZwy11tkK1qJETK6WZnQTzubAGJbKv1O7WyJsrMrbfeIAZgGGDTVWGQ46s4RB+1sLIBqX8+lSRfomnvgA3oQTCchrINuZ1ma5exZcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3738732f988so62341135ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719293249; x=1719898049;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJaoHogdW2Mu9NHiautEPTgzcoZh6vSn0WgabcVsHn4=;
        b=O3tSzK7u5YY/8j9jbZZn2rnMsAnAD5hz5zaef7i3yLFjVlgyjP3E1BBBU9S584+J7P
         ktchfiDaGKoRtRyHuej609pXiUvqdF+qjISiiSWXN9IZw4Qkeofe0fEgSIUuYNL5Kqpp
         ihxVfyWbLF/Z0omQ3ff5hkpn7qcVap7P8Yytrg7ybSCg9e41QvoTPBvbYSmpBsshdxNc
         gMGwU+aYvS2tMwtDMgvi2wDDDOrsoh1ILtXTTzU9rP70aVECa91VerbQLjW7FXQ3/Hq7
         XXqayuEu8lgTD8jzH2tlC4FN2zTDRR/iJ8muwuOh9bOZOKUgYjZQP/y4nt2G/4/d++aq
         mAKg==
X-Gm-Message-State: AOJu0Yye1VpH8qbRudd5YM0I95/sr/VMFdpSpSbexQKVBgMfTo7VOBB5
	/wHrhqtLRwMarSGFRlF1KFLiNwxf+tX5dtf2fKRUR0k3uGcSFzMGvPm+iJezVpYySElh2pPaRyQ
	si4IM3g/Px79pPrsUV1GfVb2kpPOscWjuMH3wMQ/ulcLCd0fpwO2jgI0=
X-Google-Smtp-Source: AGHT+IGHMSIs5CUbiYdOyw4Al9iGlMaInzXeMOvaxh3VeZg25JmgdkbjkhGqwlmio8Il0H9xvqljXxgsHx4fbXBBUz8Ywwm3oycv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:376:40c9:d61 with SMTP id
 e9e14a558f8ab-37640c90f26mr4814035ab.3.1719293248901; Mon, 24 Jun 2024
 22:27:28 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:27:28 -0700
In-Reply-To: <0000000000008c85d9061b67d833@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005da2bf061bb027ca@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in dbDiscardAG
From: syzbot <syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: shift-out-of-bounds in dbDiscardAG
Author: peili.dev@gmail.com

#syz test

