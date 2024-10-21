Return-Path: <linux-kernel+bounces-374442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B69A6A61
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2971F281C68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4911E7C1C;
	Mon, 21 Oct 2024 13:33:13 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77C11185
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517593; cv=none; b=IN85k9E45lzraEHdXFVkL0CSFomUGT2Z7gvWOFE12eD8j04bfCEnF9jXqWQ0/9H+55HRXhFI836zOcj01tiIblbZifvl07lI853yg3opph3B0m/Srwea21THOzXkEcnnsVVgRXZGCGHFrxzxDBMKks5Ij+5Bivz9I/XOGCPhLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517593; c=relaxed/simple;
	bh=6AlrBsQMYuHn4+tFYtaGWVVa/w9KfoT0b7uASF6xOc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wm70Bq4fo8os3pzVSAPo9/CNwApgcWTmTksxbdNJ6blWC8zEgiFSOU4pVp+FU1Y2vMZXifHVUwMbYwALoWYdKqzAXbiKloXnoL7txZ/DXvh0jnavkH7KKWsDuGqkWsVoVhK3UUE2tW7uXK/VhR/fUvqJjTepaNFYH73vE06jVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so38531645ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517590; x=1730122390;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AlrBsQMYuHn4+tFYtaGWVVa/w9KfoT0b7uASF6xOc0=;
        b=cQLBTasfbOnb6CD5G0W7S8622irjnm7Uts2AIRJkB9kV1d0v/Wshddhvfzy0DQs7+U
         ajucDPmM8JrZnfk+mMpBGEDz7xLl5e4rqPkr86NWyFU2uSxdp5bU+rLHa/JfwFcV8zWv
         wc93yPKJH+Gv4wXSKobsrYIKL1qbQ9pHZBcD3ZUmMocMoq5ODp87d1j7N/R+MYk26rKP
         /Y1LmZT35rSx9BE4/i7znTMXMu4s6kwO2BE1ymBhRcbzHw5rPi37tANI1IKeuAKIxWQl
         LIfMiT4W05XJp3b4c4J0umMi+P0QJVC9DlhwodiySPqyajDxhocU2yNpQxCb3cuNXtgR
         HnDA==
X-Gm-Message-State: AOJu0YxDAeZdPrtH9R0kp08zIz4QaZ17WjPlYdnnz49i1+DKsXFvwxrJ
	vQVa0woXEKRpchxbCSPZUdETySbnRwOZhJSeZ1u3zyLqFeX3H14BHVVoV79l3F0g8Z/W9OB4x5G
	uUTqswSQCap1ymyzMqk2+K3iR2A07HYZJ2LuctCEFqeU29POZVAti9V0=
X-Google-Smtp-Source: AGHT+IEzWPjaDgunprWz2nMapsvsZlRwA4kBpGaLiMhySRcRPAvSAGvuDYfo6Yx5CmOY/zNOufM7dmHDBTw7uWh7ilCeOYowX9gj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a3:97b6:74fe with SMTP id
 e9e14a558f8ab-3a3f406fc96mr110715695ab.11.1729517590512; Mon, 21 Oct 2024
 06:33:10 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:33:10 -0700
In-Reply-To: <6715f84b.050a0220.10f4f4.003e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67165816.050a0220.1e4b4d.005c.GAE@google.com>
Subject: Re: [syzbot] bcachefs: add check on type to mitigate shift-out-bounds
From: syzbot <syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: bcachefs: add check on type to mitigate shift-out-bounds
Author: gianf.trad@gmail.com

#syz test

