Return-Path: <linux-kernel+bounces-329593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B05979352
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 22:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B82AB2273B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9662126BE8;
	Sat, 14 Sep 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUicjbUv"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB3433BB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726345910; cv=none; b=d0K9zPgYWuqT4AsbCOljFX2QWIIj1JrHCKEfKgfHp1EiL4fvJBlprb75r7CpgFytgmorzzV8zhii5h24CwPjD274f8w/6xUT5G0JjwUaN6fop/9ESF05yGy0ubdZtk99EJvtDxLpi++8biFoHj4orEhOEgfqfGHnBakd71Qi7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726345910; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snBlQM5AZD9QcHOdLNCFAzDu3+0Nu1o6JgoFHj3/EfoCsZTy2WYQKXRH6sckebZ6/YvALBGf3RVNvstCPV4EBHgCxaUSu+IOrQJmoWi+wdbsFO2+kS3yfH+TP/UkuYSzEnUgcwiZDT21xrGB64XSk1ckWuPSNe+cauwUPlyW7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUicjbUv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2352101a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726345908; x=1726950708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=JUicjbUvZDTYmsY0a6NSmfYlwqoIVzDw2EGo7+Rpc9EfBWwDUHEEWVqwW1erQLUyrz
         SBCxo134/ImLiFmliycXo2WnOu/Nu1yKjGrwQNo9Ujqb0N/H15WqIVwGIqF1JzFqyWZh
         HXZuCEgkI+pKqJcbhb9P+7X0wUtLHWfOYZIaLrg5r0A96/3m3UwJuz1gWRdPV3yQxxux
         taEinLNpTqJEEdVxy59ef5aHim9HzSYjNLc/dpWYoQymtjlg65RPPokVAaPY2ziwxmVW
         auL6QPrcL1xa0p/59oWiNRLLtP5zmHx8BhpHNbY/W+OICP/q52MvjMVqVuXfilV6Zgm8
         MdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726345908; x=1726950708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=jsMSeadpK8OleQ5w0lfm1YWgolA4heWE3B7ZyxH+YWXSjVCk1FIxZrjL4rO8ack9hF
         eXT6UNxMY5fNozzGB9GDw7pdbhECZA6oK3xYHg06bPa3Dbf0y/Rs5q3i5t0E/CBDtlee
         SgTeK9zRUh6HHOamlPMl1urQOxXKt6RkCyuAwfhoZu2PKDIOfhiF3y1xqpeZFNJOQhcM
         8WaxiQM8i6eSrfOg0jdxH2+V7I/n+PPy+FoO4fKgSXFLb1iIpD3elitPy193TD9UnAYH
         v4SrvojfN3S7YNO57nT4GHKwWgPQ9z7SfmWVSbVko+py0c17NhnT9d/+Bf5ZMLH+W4f6
         ha9w==
X-Gm-Message-State: AOJu0YzPcCKkFcbimYU0P5y6Y+zGSoCqeRn0nst2OQzyAYOx5iwkA8xn
	4AaxYvwH2chq8eIkPsYqzwr8nouz1P6uTz5dAQKP8JQyTq2AOSj+
X-Google-Smtp-Source: AGHT+IHk+l3SNKS7G7zG+LADfPrL4IHc8NDGOAFAGXvWMkarDVXs/NfqDwreTmGi+4/IkXIa8kpu4A==
X-Received: by 2002:a05:6a21:4d8b:b0:1ce:e725:1723 with SMTP id adf61e73a8af0-1cf76243dabmr14418547637.45.1726345907912;
        Sat, 14 Sep 2024 13:31:47 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b21csm1321613b3a.123.2024.09.14.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 13:31:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Date: Sun, 15 Sep 2024 05:31:43 +0900
Message-Id: <20240914203143.99551-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
References: <0000000000001fdbd80621e28ae3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

