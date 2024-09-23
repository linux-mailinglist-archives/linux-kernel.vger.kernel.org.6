Return-Path: <linux-kernel+bounces-335787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F25497EAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE21F22196
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375DB198832;
	Mon, 23 Sep 2024 11:26:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0C944E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090799; cv=none; b=RnX9WeNAUNI7mEpVvCdGOIf4o2ISgF1zsHke28VThf0qXfAp+6rFnpBsiZLRx9hhTneGNq5Fm3tTFfgyiQzRHOSH3WEMCjcc9SJyLi5B3QY9itRsCDTIlqv84z11nxqh+rZTFUGssBCgxAeBbPUftWaNPSxPeJzv1A/HMehmjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090799; c=relaxed/simple;
	bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AL0RIv0O69agi/UcCQLEEL2XADZBOWp0bSyWs6sR8ng5H9JmUwk/bsmBIyB45oURWL+MQbVjulKG5lylA2ciTpfzUWlwKwdBgMpJTGgW+mMaVtMgQqG4e2L9MbslUk6tL8AGQG2C0nm5vNAZgZyu7rdDgroBohgcVAis8kvN4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f53b1932aso47864165ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727090797; x=1727695597;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuDa8PgCetHZz3azjtXB+wao/HQzxIr2s70KrXIXXdQ=;
        b=kZwj9eEmgxZ9PXIzsyXD6Tgp+iJsT0vEnwo46bz8pElOnKYG7+1H2/bB55vtW4L45y
         XWUlz5tZgsAcZbcG518YRMJRJqpJtIW3zYtEAZHcj0TxdJSrXgDLMbjP0Y5AqGbUfU9L
         82GMEZiHd+GMyHDLnYVqoTFQK0TIG7N1CaRDFlClKAkrIhswHXS7yWYnSgOCnuUku9jP
         EEbwS1G4ODbR5irosenaVKCP2zVLfSauUjUI4sE2ruz6P6bGRG9+F9tZQOQtKSmjamoI
         HyDg0t6vKKFiS/kD6pZwlFQdiS9KKgFxisnH0fmvnA1v9/VbD4QYwzfl/VkxRUTHqTcC
         breQ==
X-Gm-Message-State: AOJu0YxRBtparRBnk2PPZ5v0Igk4DJy4IVp4mmzLGTypF4DMEgiXenmP
	e1HUG5z9997q9OtwGaM3txuHm6NYM7IaRYLrqS2WSI4qCFxzrjNOnXNyuiw4GddEIyDGGhQBDgP
	5iyZEM75/tFvr0wgNTEQ8kh/oglHSxUkw5aCuftGFupa0yh5aD8bXb4A=
X-Google-Smtp-Source: AGHT+IE5fUfgrJT6awfVXrEt8pzx0kxOcXaWRrA+pvUiUnw4PeM6hwo7A07dZNkT6K698al+4DJKPE1JfYw9BaIny9JsNbTZ1D0m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:39f:5baa:e50c with SMTP id
 e9e14a558f8ab-3a0c8cbc250mr99555105ab.8.1727090797502; Mon, 23 Sep 2024
 04:26:37 -0700 (PDT)
Date: Mon, 23 Sep 2024 04:26:37 -0700
In-Reply-To: <000000000000e28810061fb68dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1506d.050a0220.3eed3.000c.GAE@google.com>
Subject: Re: [syzbot] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in ocfs2_get_system_file_inode
Author: pvmohammedanees2003@gmail.com

#syz test

