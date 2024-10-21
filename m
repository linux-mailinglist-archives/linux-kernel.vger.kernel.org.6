Return-Path: <linux-kernel+bounces-374611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F69A6D72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF391C2277D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48791FAC2F;
	Mon, 21 Oct 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlB6UXXN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D91FA25E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522741; cv=none; b=JJ4Q6ibgf7WhPx1pQmCtXA9CQ1VcozhGXRZF2q58JKbX8N3N8VhPgIn3yDbWjz9i2WYmrxiZlLLRCl2D1r64YORv1UlklsCtV3zQTES7AeJXnMc527gewnQIbXDZJrpS+po5lDraURw6sUCUTYKIR9/87oYa/hfwdq9AxG9Rd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522741; c=relaxed/simple;
	bh=CZ6SEFNVS3qRSLAnK/yvu+fW1YezaVCa0VevA5eAyg8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=uY5a/mx5gBsC/Mvq/SPyqDF9sprjXSs5AX77/C+PI6Ym5tDryOURAl3C5W10O8xo/vnHl0vOAHJDcs2baMqIUA3sA2qpQjB11pyt+kL0RIK9VbHEI2gUl3iZxMO1Xg7nyvSyEnPpiDLAkV8nN6j/0o95sZfpGv97U4dkqD2AQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlB6UXXN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so37592105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522738; x=1730127538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpGB9N2DmDpT1XQN9+f3quLzns6BOb/yPogCl/KM2jI=;
        b=QlB6UXXNqajIl+ty/34nXv+HP4egsgEIdc74JfG3EjWvJ+jSPIyBwTEqHNfSMhyWcw
         WuQU2ltVoR6B+58l3em2Uz717TVh1AhLgXmWWwSPnkAhZX1EcKWplxqFW1mM9VqhdUF9
         GkZh6xbkLY6mNur1mbmZWgThYYy0ySLUpepChz8iXU9R0wgnWvkuypgSrYZmclVWJen5
         u7mC5AEw8t9JZYvr0GRQRmLXIVB/vEl9LjaolhCFz6IyhsqDAQgisjI3QbTMKmSqLuIs
         83RH0RK33ZtMeo3cYMOBmWO/2gfVsWZPypeTGQ/+z+0mWb7dakiOtrjGy83r7wU/5aZy
         zYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522738; x=1730127538;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpGB9N2DmDpT1XQN9+f3quLzns6BOb/yPogCl/KM2jI=;
        b=MaPOfCaoRlVI6oAVYlRmuu9fUac+PPGuxMMnXvj82zHVt1WRF1INyZpHpv5gn5OtYn
         p7yEpU4qi76FzsvmMbgLH9EF9uYBNAWZms7A0wUqSxpG4SMTB9qpaILYhonyM8624Hy0
         St9RizoZcLqYjLlI1RwyQp3XVX557yPJdcL5CXhSnt0d5MV0goyfP0ge6vGU6IGU/AyT
         GyKxxl8w+m13oel7COWgofga3MqrJp21zFOFbF5FzFE9SM9cxVCBgVkgOa8ZRAY8uNqR
         58wtAmI6tgpjXNZ3Oxm8eLqeWl5s5UM54gV/yYkC5cF1DizMePHek3dGlzoYB/d19Rq8
         qqPA==
X-Gm-Message-State: AOJu0YwTjvLtE9bF02l/h02GisNfKWh1Tx/tFSp0AW7fEtFZhyIuh/OE
	+9p3ygetAeCBuXtIF48B2OOs42SC6JFcpk2znJy0Q1Se39b2hxz7vK5BAl3b
X-Google-Smtp-Source: AGHT+IHPxRxpF0/Oj54IT2/suq+P3/PpxMGWq2Rf/iq9OftN8YX+MalaK4PutV0kp3d+b/N/c1idbA==
X-Received: by 2002:a05:600c:1c95:b0:431:594b:8e2b with SMTP id 5b1f17b1804b1-43161657e14mr84426435e9.12.1729522737405;
        Mon, 21 Oct 2024 07:58:57 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.34])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f58c02csm60717815e9.27.2024.10.21.07.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:58:56 -0700 (PDT)
Message-ID: <ecd7a510-addc-449e-a5a0-3ea144a76917@gmail.com>
Date: Mon, 21 Oct 2024 15:58:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: linux-next: kernel/trace/ring_buffer.c
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Static analysis on today's linux next found an issue in 
kernel/trace/ring_buffer.c in line 1538, after a 
raw_spin_unlock_irqrestore() call.  There is a return statement on line 
1538 so that all subsequent code is not being executed, which doesn't 
look correct. Not sure what the return is doing, perhaps is a 
consequence of a mis-merge of code.

Colin


commit id     line  source
1f1c2bc9d0753 1527) again:
1f1c2bc9d0753 1528)      if (++nr_loops > 3)
b4b55dfd96505 1529)              return;
7a8e76a3829f1 1530)
1f1c2bc9d0753 1531)      raw_spin_lock_irqsave(&cpu_buffer->reader_lock, 
flags);
1f1c2bc9d0753 1532)      head = rb_list_head(cpu_buffer->pages);
1f1c2bc9d0753 1533)      if (!rb_check_links(cpu_buffer, head))
1f1c2bc9d0753 1534)              goto out_locked;
1f1c2bc9d0753 1535)      buffer_cnt = cpu_buffer->cnt;
1f1c2bc9d0753 1536)      tmp = head;
1f1c2bc9d0753 1537) 
raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
b4b55dfd96505 1538)              return;        /// <- issue HERE
77ae365eca895 1539)
1f1c2bc9d0753 1540)      while (true) {
1f1c2bc9d0753 1541) 
raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
8843e06f67b14 1542)
1f1c2bc9d0753 1543)              if (buffer_cnt != cpu_buffer->cnt) {
1f1c2bc9d0753 1544)                      /* The list was updated, try 
again. */
1f1c2bc9d0753 1545) 
raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
1f1c2bc9d0753 1546)                      goto again;
1f1c2bc9d0753 1547)              }
1f1c2bc9d0753 1548)
1f1c2bc9d0753 1549)              tmp = rb_list_head(tmp->next);
1f1c2bc9d0753 1550)              if (tmp == head)
1f1c2bc9d0753 1551)                      /* The iteration circled back, 
all is done. */
1f1c2bc9d0753 1552)                      goto out_locked;
1f1c2bc9d0753 1553)
1f1c2bc9d0753 1554)              if (!rb_check_links(cpu_buffer, tmp))
1f1c2bc9d0753 1555)                      goto out_locked;
1f1c2bc9d0753 1556)
1f1c2bc9d0753 1557) 
raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
7a8e76a3829f1 1558)      }

