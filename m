Return-Path: <linux-kernel+bounces-299291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6231295D25D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0CC1F215DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923F18951B;
	Fri, 23 Aug 2024 16:05:00 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964C18BB82
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429100; cv=none; b=izQYNKwtHT1OM4X++40IhN0+SHzVAzCTIwSHnj64q5TLdNbd0mNTqvMe7+UAz6YZuAmZryGRXyNc2oCVYwVqVYj59mdJMCgeSoTumFOxBXmc+q+ENr8fmoCBJPZtu21zF/Ab32F0Lbm30Gm/2oHjrBnPcoHU+BAVR0GPy26h+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429100; c=relaxed/simple;
	bh=Cp2pgca+yiV7OzD1NdSZQbL+bCUa+O+yEXL91qOfnzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n68WmKGISxY8gH7JDZUSXOeDrO/RQ3aAWS7gknMiqdSJoXi44T+gbbNQ9aGjn+s2TFxHKg9QvmMCct0T5iIPpBVFzLx9iV1qtUzSyaIQoczGzohwF5GRdrvUHKONge/RuQKZN9Zo8s2M6Z3I55VLJwogv3u37tv8hAi1qkVzdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d244820edso19267415ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429098; x=1725033898;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp2pgca+yiV7OzD1NdSZQbL+bCUa+O+yEXL91qOfnzI=;
        b=bRYLlDD0jXYjpN1DAoTvHkPZ2TjxIL+x5vItlfn3Ep2uxQGWFaZ1KNomXENQZDL5cA
         BUF7kly2q+5JUdOOyesex6Cb6zEVnvpOEVBNibr3pgd/wvCRAwGpgYWbGZkXq9Emn8xA
         KxNcZTxklc9qz3i85PqrOr9mmzx6ghtt1JIfdkTpiGgr50KSMBKBgcunApF0XQ1lrr/q
         YTR9K6v7kv82pynqXp7QPBtDnSv67AtgC2EDmKxOuQeQ9ggEQvhaodjX1GTGJ/qVJ/VN
         2oAEIpmF3T+74H/tEZqjWypH6rYlmdfoEnn8Sgr+rD6eRPiJWcAZLRGg+hHbVqM6jzI+
         YObQ==
X-Gm-Message-State: AOJu0YysKo5RDrNwZHECXjm+PHNiHIYGXLZnpO7Cn8jPezW7Iz0wIEhw
	GQ969S6GoDX5rlCs5hft/aycxOJPqHKLXLWj3C+FzjeAqZT3P3/HcesJ/GVA2NgQHilRN2eAF80
	MLbtMugpPf5vZj3iqdtOezLpBy9QtkjpJUduDNloEedG5TtIdmPmbz7E=
X-Google-Smtp-Source: AGHT+IFF4UizVlYxyNwHcxGvW4sXWmWUvmeyqFGeywvSsdP6PKJUKaXv7ZZSWIfvRYMF0IlkENQ6tp1dD9KdJpNMKGnHE3wUTDiC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39e3c9fa817mr2143465ab.4.1724429098001; Fri, 23 Aug 2024
 09:04:58 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:04:57 -0700
In-Reply-To: <000000000000be9914061763f17a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3b8a106205beff2@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: BUG: unable to handle kernel NULL pointer dereference in attr_make_nonresident
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


