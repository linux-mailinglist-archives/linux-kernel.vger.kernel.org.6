Return-Path: <linux-kernel+bounces-252272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5919310CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC101F22CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E41185E73;
	Mon, 15 Jul 2024 09:05:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49375223
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034346; cv=none; b=SU3SXed+rMUyzXb+A93LtDeUrpTcgSVIFUSt/MkLULOJ73NFGIgy36mdWxrvQZcvIiQ0Qwaq1MDTiVCwo8d+tCjJg1ph5sLJ3yYP6t8Ee/IxVIQ4SYxuhcwNoaDo9/lw7CblOE4NMZyv1HgEy/PYfwdBz8S9cWqkTjwbrQCD1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034346; c=relaxed/simple;
	bh=Bqe5B0nHM8yiM+AfbZk56Z3m0Ur+abrE+UL6OfGJzfI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NMlX95oWtkxPv09gVZRc6rCR7hgzoEzP30fw3MNHeOyEloRVbsT9HFv9Zb8m9iFubkXny/NLiAWNjSSCXi13qOzZ6ownWRElaz7m9SejbBy9tdzByX0tFYJU9QWQ3k8sNQv4P1peGXLhifEZW4fU97UcM2FCV6UvuUFdQedewmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f12ee1959cso494297639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034344; x=1721639144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyw063g9auUfmY8JT0Y0C0LQAIrzClzIKwSDZiHoezc=;
        b=NDTtGR4cv+VWp3eCqgUdn4jXXMJK2Blm3kxkyBg9exDyv6o2wrk4Xzqu/YtIvNg4CX
         YzuuEB3KWyAu01iAm2JC8SXcSQdDNjQakxaeAeoZVYyEaKMQbE4aTxLoTrZgLQcNjW4e
         L83bDSrzRyJl12diWeae0N+yID9ipIfsx99/xl2iq5qski1LU0vNIczPn9oNP1wgXug8
         iLWCfs+danl+dXxkuB5ENuiFylcHin/LBGTQt0zADvFIHzcdcl7jz6GyAch6gnkTvoFI
         xI3rUnsVL4XfTm9DWEXil65IMxaZCCDBkEwMOF81DG53wglDi4BCb78WBneNbneApw7b
         ASww==
X-Gm-Message-State: AOJu0Yxjhv/s88HEhkukB4+HkbSccdnkMhvHtJzirbpctbtdIrIzlCX6
	bSbiAHYp//plRXcVT9Pyr7bS0yuYphsuiHVoMOca1/+MqluNUsjOCBSAkNwBXFv1PL3Fyh6GHMV
	77e/imEO6UfPnFhDY8mgPUDaKG/9rftLHVdK+Nz2rIcbB6V1pmzLxAzc=
X-Google-Smtp-Source: AGHT+IEkiH0SorNwlOSps0s+VlqDnyh9I5/gQ19RndTOE8/c3dGmr9xm9yx49+4h2rBmL9WBY7ag3cpqD3t0QOukCJ2/Rg0gxu2w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1316:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4c0b2bd6b00mr1256609173.6.1721034344083; Mon, 15 Jul 2024
 02:05:44 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:05:44 -0700
In-Reply-To: <0000000000009a502f061d1ada4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9bfd2061d458859@google.com>
Subject: Re: [syzbot] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: general protection fault in run_is_mapped_full
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
2cbbd96820255fff4f0ad1533197370c9ccc570b



