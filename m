Return-Path: <linux-kernel+bounces-373255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A189A545B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1338D281A62
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9819259B;
	Sun, 20 Oct 2024 13:34:53 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4F4C7D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431293; cv=none; b=ALIE52azb6C7M5mfHTellkN4joQhWDQwLy0Bg4eVwCgw3TifDGXoQh04W5qtMgSTyYFGvrqtZooorrmIasuDwHpqfNU9vRvI8TtUmfMgfMikGBZP7bicFCntfWlsFFeBMzJBFbulkBET95v3zZKdEB4JDaA6/6kngWvaRpbY9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431293; c=relaxed/simple;
	bh=xLTPOb5GXCMRP2mzWWEPajTzoPfh8y0HFw5UHMTXxcE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ABRKYONBaO2juDM2kU1rbmp4mi3u1g3UEMqYRivfBEJXp4CbxwZWMdo3Aot5wcI0+v7AUCxT8FLxb1sbjf/tG6M2c2BGF90kMj7nrm+HoW8ulfdfunpVFwgtP2+KVxYsj8zN4/CVZOdHoU0XmVt+AHfV9CcR8qrL/AyVgL5WTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso37852095ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431290; x=1730036090;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLTPOb5GXCMRP2mzWWEPajTzoPfh8y0HFw5UHMTXxcE=;
        b=Q5t7myV4HabgudgXSnY3jw1L1FyWxRDAe3OO5L9xT/nENE2Bmyg+sD3U/a/K+9qZ+a
         b+DaE8n9K3zgihmvy39xrlQZg5DB32QUusgKeu5q5217n02Ja9cnsG+E2HiPJnpwvoL+
         nt0d0VOx9lnNCZ44lTc9hkmZGiv0YSF0dq2HUaZDCO9pDE074Kous8x+oeKdw9bLqIPG
         +y74/+wO4BFWwsHqYzWGQAsB/Z4LM1cnLdfuywfx9IUfSwffeaoQ+3CZhFR4MhlBtNLH
         AnyGotSRmm2lcliIRrycukshz0fJKZt/5m0jtuRz+YcjOsJvwC6bEEeTVrz+DhkJ6vS3
         buCg==
X-Gm-Message-State: AOJu0Yyls5eYiAyc8ClS5gUvLG94Iphf77tEifLyh9dH4WCk53h4MYzS
	GsWHcnBDFxw0/8EM0rE6XNiSMNKkoVuluUZTYuFgGa9vEoBabRo76MYNDa434zYSTJKkdzdJxc6
	LLok8yT7fBX+tIo6nQULSImrvwl0QOaofn+qOcd5lDCPXrmFE5jvyFc4=
X-Google-Smtp-Source: AGHT+IGhGNQDDFCpL3+QTD3+GDA2J1Sk9gSQT7gkRbIth5wQ7tRZm789Mpm1/C3wXJZIesL/THHGXq5gG+JwoixtZ4jHlInlqxwG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:39e:6e47:814d with SMTP id
 e9e14a558f8ab-3a3f4050940mr76152795ab.2.1729431290616; Sun, 20 Oct 2024
 06:34:50 -0700 (PDT)
Date: Sun, 20 Oct 2024 06:34:50 -0700
In-Reply-To: <670ab2f0.050a0220.4cbc0.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671506fa.050a0220.1e4b4d.0043.GAE@google.com>
Subject: Re: [syzbot] WARNING in thrustmaster_probe/usb_submit_urb
From: syzbot <syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in thrustmaster_probe/usb_submit_urb
Author: karprzy7@gmail.com

#syz test

