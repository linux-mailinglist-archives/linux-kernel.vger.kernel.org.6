Return-Path: <linux-kernel+bounces-319435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659796FC91
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA56281813
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0111D5CF2;
	Fri,  6 Sep 2024 20:13:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1DB13D251
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653604; cv=none; b=pgkx75VC3Z1bkehRkcaAwe7164xcTvXymr1q6yTAGEb/+BFnp0be0AIkl2VGTY1t80X3U1sPVX5nD1zMSPfAYlXFUcoMZ3dFRjMtYbiGBjPK6zm8BhCqQ4GTxrwkV4jOI6KVPTzxyVlTY5wOcKCJTyU+oWTomyqDCviGpcQlI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653604; c=relaxed/simple;
	bh=fqEUP4QCczMa9bc/bc6lgJ9Oxojmhatk4UnHDrqVitA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Drr2bSpa5Ea2ZdoZmUvIjGWwoDWl+wwcCHz/rwFsR7zjsCAwG7c0lcWhDlfmIaFskrzANWFcbtwF4yQFTEGGTr/vA4S33LseYNdU4slGObH/6G0DbTMGQgjxQqwZDXF/yErviTnOxBgwrMURCzJtuB9P3CsWEc2t7GufpURhnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa4678394so10640839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725653602; x=1726258402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqEUP4QCczMa9bc/bc6lgJ9Oxojmhatk4UnHDrqVitA=;
        b=J+8AHBVPmrbEnK/nNdPQnHeu5sPws/TVmuVYtf0RvX88X0oDGWY79FyrQFYnhfyFkI
         zw+MJQ8wmbtrFyvahAJ7SF5L+dr+YnrExs8yS+wcDOYTTL4/dxC9s69I3l4JPBKHOI7H
         SPhF5qEM6nayKemfZ6B+fm/YOQk1uKulx9M45YLv82Kp1F23czZkUDcEzctxFmwK6cYx
         ISqdYdN4f/z+PCYBjGmlMWrudlYYGzYicd5ADlhXUY3FrdiKVrAhSdNIYkD7gjXa2Edq
         CQkGdohux/ZAPrZ55/xtO5ec090LgKtI5xXMe2V7yv/D5Uu27fZhrAFSarQlKPE4f1UF
         YwAA==
X-Gm-Message-State: AOJu0YzZp6p7FfTvArdhVkkperSzIfwcvTU7o7rO+wQSutyPBXN1qFar
	YTpgfw9dHDinqSCD2XvtmGiAsm4ToamGmBQn6Ih8E/7VC8di0zLnxpdxjpiAa59z7KvyymSVeSM
	qZdlwotzncp/g2RDscQqjcTmWyvwtxrjiwDfa/zz5zcdLe0PWSBSbrgs=
X-Google-Smtp-Source: AGHT+IFz9zUHmeX4an28mIaOsqHLG71tlX1x/x+aZeE35/KBqQhW8OWiblcRPeQg/uYhVB4mmrJcABbTQUoGgWFagONM2UIMogI+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:204a:b0:4ce:8f9d:2d67 with SMTP id
 8926c6da1cb9f-4d08501da2dmr49585173.5.1725653602125; Fri, 06 Sep 2024
 13:13:22 -0700 (PDT)
Date: Fri, 06 Sep 2024 13:13:22 -0700
In-Reply-To: <000000000000528f32061fb69112@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5dfdf0621790976@google.com>
Subject: Re: [syzbot] [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
From: syzbot <syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
Author: ghanshyam1898@gmail.com

Added null check for block head before trying to check the cache

#syz test

