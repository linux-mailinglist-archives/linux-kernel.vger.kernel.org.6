Return-Path: <linux-kernel+bounces-331917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE397B2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E584D1F21FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203EB17ADFF;
	Tue, 17 Sep 2024 16:26:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9A535DC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590396; cv=none; b=IYWutwFSCf81aAuGEOGlcACkUhv0ffjD86vRzgfaQgu8dEH4DewGoOACuNtsodAVVE4id5ppn6NCj7i8DsgYgJ4MODT+cswgj+XAEVRRdsfQieXyXz4xyiXwsasEv1QI2wjeE8Ttmmx/wkCVwMv1x1M0H18qspORBPx6ch8H/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590396; c=relaxed/simple;
	bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uKNTlSZy+Ht5PNy4eMDZfVfeujffQMbnjF4RPsI2dAI+iB1+QGlBTrb7EMNd3zsQF0yGEO2U8SNjAyswz0gCPnf1AtI1FqwgWkhEbelH5yO9kchMdLNeiXQ2KYEB7ub58Hn8cartLVFLoMIKrz1EwJMAm2OQcJwJExAtY6EwwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a049f9738fso92384315ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726590394; x=1727195194;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUkNUaswIa8P7UVmusL8ktZjfYKFFrALf17jGP5Uc7c=;
        b=I75sJIjnZaBfTZ+85t8Rk5fF5vVIjoJb3UdlzKrubOVxFRQnoUFz/7N9Imz226TTdP
         tJHxynRq+UqTxaxhHhd1Eb79Ej1DBkORdwPthP3zvq4nwKQRWUn6lR/AQiFPS7jd5Bds
         mIp/7MaRq1QB7RAwPcixFXqgakJ1cmLjdDv6HYcFZe1rFZ/5gTJtBi+bupM7e2q9zR7I
         5hN/P5mKJM2HV2ASxotWyxpSGUn/ypDCdP/AYhc0fw6woK62RaaT4sMcVr8sxDA7zcUV
         tu8QIMgWTrm+sEiw8N5AmqVUwKB0klAMZluuBhbtO7fNtZX99ik/7TPcbn/kbHTOlQa7
         nkaQ==
X-Gm-Message-State: AOJu0YxS4z6XsgWVe9rXmGJ7Nm+/MRY/XYl+3BKPEJYA/VQSqIwR+tMU
	A3ekxiu3Wlfc7MXoQGqX3aZXu3MsJrgrvl+PSSnOFj2GlsZQV/ft7SjdbV+hSKywQemPOVkFpqU
	UtEIHJM3syfycV1k6+IaJ6xTR9ZWYb3gU1qUf7GjCIZK90FuoXiRSjts=
X-Google-Smtp-Source: AGHT+IF+A8VdQRObvBdpeEJiiPHZdzMw5hq05KoI3N94D6hJgCmomxQ9G7izTrtTTi27YUYnY0u+mu/1Np2161VpSppzBnSi5hP1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a08b6f87edmr141909805ab.1.1726590394383; Tue, 17 Sep 2024
 09:26:34 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:26:34 -0700
In-Reply-To: <0000000000005ef449062240d69c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002153ba0622532716@google.com>
Subject: Re: [syzbot] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ocfs2_write_cluster_by_desc
Author: pvmohammedanees2003@gmail.com

#syz test

