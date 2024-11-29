Return-Path: <linux-kernel+bounces-425911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3C9DEC79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C42C2817EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B601A256B;
	Fri, 29 Nov 2024 19:34:14 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEC14D430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908853; cv=none; b=aslXPUxseU0Mxy+uaUWpN1TEwD65iIkJmZJOoxo2h1LFtNlsUihomL/VirqG9iu5bYlKmKVljeHiFrgIA0/dftH9BsToyjrOb+66Fmm/xPWeF+H8pJptGx+W4IpvXWtU99cf+y+BdKjIvml2XZZtMfs+8OEPPT5CcpTyyE6i168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908853; c=relaxed/simple;
	bh=jOXwzG1YkVgr+24WoIUdr0bg0h/ZSpxXxmdKEZIOh+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tzz/owGJHVFm3i6DIeH95bwsryAYC2yrSnYR0NYSwgQsSjzgplq/T0LoHnqtHIOkFBA4qEFhk6ZvoPDH1ovWtKpctSxXPWJ/L1Wj5gLZDaHxKktf/rdWbYpITFKkd9y/1GnTxEQc7rZvT/sfoBiW5zbPJ6sfPkVTaHnw0gWOjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841a4a82311so168412739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908851; x=1733513651;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOXwzG1YkVgr+24WoIUdr0bg0h/ZSpxXxmdKEZIOh+E=;
        b=YEZJcKjijBM82YSS7CtGc6nN37woJI2Hw7nThJi3x64M/5C6YK2MNB4zWWyB7IpPpM
         0mHS8hRRB2EOYfIrb4JRRNzAO57J1qIS3FO8XyYNzqtgYW2DZwD1XagJUql34TGspu9Q
         NeZBIK8pAAMqArJmwFDIYcCI6xQj1pNMaP9C5utIHlZ3Nk+mSi0Sej1A/vO3+KvMBAiR
         w/8Wr2XwfpMMAsr7pXURf/8KqYHCfJbqog/SOjaD6VxJkKOeh1d45FQa6jHoMZE9upJr
         3NAVaN4CB0F5w+rU4UOEkE6AnjJMTCeCDkfeicfEqNIIj7SBEblwWuf6QY6CsJnCqUR1
         lxdQ==
X-Gm-Message-State: AOJu0YxmU9zRVp42OwnvMjlNyEnW+BV2RjhSU/vtj6Tixi5SXdq4386d
	7EGhcY4FlgL/aU8j3Tpm6TUeLUCK8OB7DqeZVeTRVP4xMzjgPjc33afd/mkPQ/TJCdcbk0G5S/M
	iGexKZQjHy+P3D0K34WHst4rfkJvKqjebzrscmswRSadPxndR97+gBJk=
X-Google-Smtp-Source: AGHT+IHtz1Mj6VQCKrd9lQhz8HH+EmNhnvM/qi/q/4E3NPg5DxQArx8DA1aojaHvQKNwyxekGPeT+0bVDgb7+3wNW5yacpjFrU3/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a6:b0:3a7:783d:93d7 with SMTP id
 e9e14a558f8ab-3a7c552596amr142692835ab.4.1732908851420; Fri, 29 Nov 2024
 11:34:11 -0800 (PST)
Date: Fri, 29 Nov 2024 11:34:11 -0800
In-Reply-To: <67475f25.050a0220.253251.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a1733.050a0220.253251.00c2.GAE@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: null-ptr-deref Read in fuse_copy_do
Author: niharchaithanya@gmail.com

#syz test

