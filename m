Return-Path: <linux-kernel+bounces-334997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD797DF82
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90F4B21365
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100914EC7E;
	Sat, 21 Sep 2024 22:53:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3423D7
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726959188; cv=none; b=ISrlpo15r1eLNSxkIbTaX5kWMPHnX1ZatMJoADIWQaKaIkS/8aP/x1Fw0+g0y5fI4We/8HnM7CpJk7zVhg+0lAGUavLlAcghN7iFJBSmrkX5MR/BT4BBOWeFMhGH2lURiB0W0yc4UTPM/wyr/S35BCHSPxXlOb5qzCjBM+mmRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726959188; c=relaxed/simple;
	bh=3nxE61SAHWMmac3HzOp0hoeE/+FIcFf4/3Gr+ukaby0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T1zgLF1vsDsEATesOKPExp8zJbTJw9KiVgPQnjNMTx+P+yVBdYUxn51YLNPg2l/pPEZHIAQ123E4VtvzfDaH0vLMB8D6XKt9wWc3oxAslOwLnT+r6gbxh1TRdgUpjJgISWT3MGYAtBdK9peqqnDrpQe15Wy+MbAZDqa+fRc0d90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a049f9738fso35599735ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726959186; x=1727563986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nxE61SAHWMmac3HzOp0hoeE/+FIcFf4/3Gr+ukaby0=;
        b=cWgtlC7ev91kcA6UYjkNLZjaE7zCvcHt4FES2sb/rVw2Zb/tJXJQun1H6jQ+3Wvmbd
         UT+UQts6UaJJcGLFPigzywWiMwtzvOwXAJvPbnYjpV2OQUnjf+kfQR9DNO6y8mDJRSRt
         VaJNf/yvSJ6urwwYsDqbuPuLMo/QV7OK0zpbPQUzOlx/bd2t1+vT7IDFaxwfnvRD9092
         Db+8cOtD/maqDYyR2m34M5X3dJ4IxBKdghUvPZvErfFhO/F/c0SnsDmfgyqPyy/c0cxw
         DMVmK1+RUFMSnQ+C0F/MLcaNxIIyduMfT3c7L2Uh2DLDk1FWv+Hsmi8/2ZfT/cB3rBtq
         DRNQ==
X-Gm-Message-State: AOJu0YwtW47i63LXLndHjee3HtkNw1WoH9NX0FjVBKErZA2KYhhGe6F+
	YeFUD7HqoPl6w8oc+vPSmbR5AYz5pCFJ6Iw+f7ptE7EQocjn5kRxDwkO0ZfkWQ7ecG0ibRDJLAT
	DRdLeovaJjJm57M58CH0E/mkilzPh4x55mc2DoG5cf2ULr8Gj3/JADCs=
X-Google-Smtp-Source: AGHT+IESO7ZYQa9bGg4d/WzKNGkqdqyNQhW/q0fqXVrte6gjsAi3ZaG5x9ODLr7TQVEeEoDgBJRuXqkntQKNx3Fi9MK9+2l67iWu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:3a0:8e92:ecd1 with SMTP id
 e9e14a558f8ab-3a0c8c61a8fmr62559795ab.2.1726959186584; Sat, 21 Sep 2024
 15:53:06 -0700 (PDT)
Date: Sat, 21 Sep 2024 15:53:06 -0700
In-Reply-To: <000000000000b5ca0f06223dc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef4e52.050a0220.3195df.006f.GAE@google.com>
Subject: Re: [syzbot] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in prt_str
Author: pvmohammedanees2003@gmail.com

#syz test

