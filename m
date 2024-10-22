Return-Path: <linux-kernel+bounces-377033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F69AB902
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61EC1F22CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADF1CB304;
	Tue, 22 Oct 2024 21:49:01 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E7136E21
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633741; cv=none; b=lXIfgtTQgnuvLJ8qHqcnColpfDmSEBIWrhR6ReoGvL1ugZha/uxNO+ZkA3FTOKhUtt+SG0IAGLdy5EXIFa/45EyHj02CRAb7+Y/w/SGCU6Qw7vBNdmQxVYSwqqFtEtcrmUgpqc70do0vuKFZmUMAH/vPbeMqClpRFILFuZi3Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633741; c=relaxed/simple;
	bh=hgoRgwn60d3VAzKBWFskiRRe2r5K270x6LmK8y4hdPY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aB+0YmspeBD7NZSz1tOusWeqI6UDF7TJUx8a9mKZMZf38dz4tvQ+lpu/nPfuA4VrOl1stAf8djAJkXrOAFEg0fbuVYJjuIsRttG6Ojr5k3Kf/EoRWWy4xhtx0C6WSHTJZFuduGiK/R/RbeIMP1xe5Voft9OuiMqSZmAQgKoM0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso63004995ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633739; x=1730238539;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgoRgwn60d3VAzKBWFskiRRe2r5K270x6LmK8y4hdPY=;
        b=oitqPC85UFLbUBft9A4LSu1pkl3382mt5OGDpJPTit3KifGcidnKgwWITDI/ZeGcQ8
         ttNUqWc5BXxXZX4GQIMFc0dcCSAqoL24XFws3mmEJzR9J4t16srIzTwJWEurPADeGk7w
         WdjuRQ6/A2MLQUxIf5AZjWtSvVqpDJivnacn2YCJCIkfJ5r+5aV6rRMvcvbsFXVIA7zz
         30rh/zNPayB2cOnNj/Oa0ZFdgGVSphbDlf6Kqpicdw6aCvAiosK1e/254Zrxy0aruzVY
         Nn3AS7RcmSOR2iqG6a7ZSVXCtPBwpSjTG3ZL9cKw/J3KD2toJAqAG/OK76Wlsqtu7F9t
         n8Yg==
X-Gm-Message-State: AOJu0Ywmne8VPsukkcPgrmH4a485d8YJZ1efVLqzlrIlx/uRyRdMu0Sm
	h4K5D1Y6K2xlH/RnUKctERLv54ewx020cYjL85OCV15PU/bK4qUB33ALnDYJ32+1Sv9obxuyJWS
	ajA9qXUWDw31amclDjReAFadOIo6s+dga1/r1UZP7PDMD5b9XVrO0QVw=
X-Google-Smtp-Source: AGHT+IH1JDQ5mOMORl5uksKAz9LtF14btGraBbeST6eFQfyGiytT4zzduEX4gPbYotkf8jzSQ/Gz9w3OPzU/4YDc3VP+9bv39A+C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a3:449b:5989 with SMTP id
 e9e14a558f8ab-3a4d59fea52mr5376635ab.21.1729633739333; Tue, 22 Oct 2024
 14:48:59 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:48:59 -0700
In-Reply-To: <66fa3eb3.050a0220.6bad9.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67181dcb.050a0220.10f4f4.017d.GAE@google.com>
Subject: Re: [syzbot] general protection fault in btree_node_iter_and_journal_peek
From: syzbot <syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in btree_node_iter_and_journal_peek
Author: pz010001011111@proton.me

#syz test

