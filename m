Return-Path: <linux-kernel+bounces-342974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD998955A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5526FB20A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A161684A4;
	Sun, 29 Sep 2024 12:32:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7E1DFF0
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613153; cv=none; b=roHsMjA4TJFsQe+vXfugLImY9qzu/ShpBQKYBMgSBRUMEImCHwdx36SemwiwpUpOglg596Z1PrOsh476ERafH/0nOxIkh3l11O09lCedWAuDlymeOdMGbvt/Y+4LQqk1k6Qp2JWMXwP8pVhHVwtGfbgzSA6yjwG4FuFXKpyMBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613153; c=relaxed/simple;
	bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z8ry/I0PFW0OJqHm0GsfJqjGNlwtjxVU9etxdmSWGw9QdwSmDzt7BTodQltPiRnPtdynTiU2hmjo89T+p48B3yleFGlCGi+s0nUYKa59BCKGvyyCFlU41xg6947kMKoUzrZRd3YqKOfcVyW88+4pvV59ahD+lQVmA++4WGJw+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3496b480dso19603505ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727613151; x=1728217951;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
        b=gvy43cOmYBuAnBKydYT7U8ZInoIlJ0OOBRBm8PVAP0U8DMm5ZCxI+HO+3pcVkNagAu
         /tDXkqntHQDNKPDoOkH5jw6anJIzmtGJ6CBHJrCqOes97lrj3CqP/ky1cGs6gKFHWE04
         J5gBA4b9kJ4wYdFKnLxsvW78xzb9JVdBITcHH2ZyH20CeligUt4bYMF2hQolWEtcsCLy
         jHCQc9oewT3tWpDXol6QgKs667RH/HSBxpPlrYeQmwRHO2e4LdGCWbp5+rguPxf96Y67
         cw1RtTn+ALHiMgcRXnFuOf8gWwPAcgEKKb6V2MW1MfCxPnKGfLorRA3MVgVqtSZgbhrm
         YEWA==
X-Gm-Message-State: AOJu0YzQv8nmnp7gJUU4keuS+J9Gz40n/JwlmFUrFWfgcfKThI5jI9bW
	mXcsgabj+w2Xin3+SuqhEHFKwJ7iElfgUjk2xWTBWjKqiaYI7mRopJYYGz70H+PvL7FESvbwZJG
	inKTcOlg9GQFWIN76PDf/rFvDKpw51v7k4thznJJnU4K9ROWwxeeFcCM=
X-Google-Smtp-Source: AGHT+IGRWu9ZuNkiKEdoANoZq6gWsvxMIScmR5DRBnkY2FPNBdRohQnEVVF0uE6XxOO+w0sIBQlfJZznZHytNM3LUZGcpmdMuYNk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a34514bc02mr71936005ab.2.1727613151263; Sun, 29 Sep 2024
 05:32:31 -0700 (PDT)
Date: Sun, 29 Sep 2024 05:32:31 -0700
In-Reply-To: <66ef45f0.050a0220.3195df.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f948df.050a0220.6bad9.000e.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_btree_pos_to_text
Author: pz010001011111@proton.me

#syz test

