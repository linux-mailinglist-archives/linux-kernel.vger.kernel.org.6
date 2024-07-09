Return-Path: <linux-kernel+bounces-246688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5892C535
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2931F20FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C018561D;
	Tue,  9 Jul 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR6zitnJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0413B7BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559697; cv=none; b=S5vgJp7IwMPxDGw8o9N7LloIyVulZiVRQxtU59ih3fbLn8SJ3bHgzovin+N8kwYuWr9UEqcL6ssz+tH8s7ENOYhouyj/kjUNRzC1YKgeHJ753AI6lDSSO/Z9UNjr4g+M8V/m+YIxOcJpVS1lGMTgDxt+aUocZ7esePKh47dtJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559697; c=relaxed/simple;
	bh=uD65e+XDc4YQVQaGyvObbmmsUxtIkhJzMFFJkuqJ4vQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dgCuNrA43BJ3Xcs5/YPVh49t5V3ZHSpX1rd1KCgwzucgY+9GKAHI5KcJKfHysMewzB+skG6JMglqFB/3C3awZdnfIqIDRcj44ZNw3iNz6YZ6C2qKwib0IczTFQzG6AnsDZFzERn1Swyy1MVlPRkC33XKRaGxoEz6w+KjOvH4qmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR6zitnJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so277171a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720559693; x=1721164493; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqUyMrk3Q8nrTi40Wyrhb+9lQLAEkjuGepH9/SEpuRw=;
        b=BR6zitnJ+s49rhLoemTK/YEsXLp450dtowSJwCl2sjskGpKfs4XX6UCt5wXPpOT6DB
         RCGVlcymjfaagTFf8mJb+CpQG1BUl1D6kfr8DQuWwwZnatZqKYXLktwLVNDRzkDisL5/
         rzl76pkYp5vD054Luu3oYRj8Vn+WNMA4xR1G938VCj6n6LqRjRMtB6hQNSAfY8BBJZc2
         VUJje6hYQrHk9ijPZUhUiSEDOZ7qVAFefipez13lPTIH6pDRZdjyOeVAjyf02Da0AGg0
         EtDdO52RvMsbW2RtOj6/F+duvTcb+T3tvZ0KTWbyuy+JeSI9MO9WbA85MIELYnJ7DmJ8
         MnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559693; x=1721164493;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HqUyMrk3Q8nrTi40Wyrhb+9lQLAEkjuGepH9/SEpuRw=;
        b=iGolBea+i2YpzBj+OZoLRZaFMWGayrrYEFhSzxU+6SjDjzxaXYiVnJbFc6WWE22orp
         oBShWlPOSqmC81wpgR3ntEoFs+eS8e3tMtyVEpOkjs5KFinuDWZcmexOEVeztWOMRDBO
         ffHpodJUx9NX9x34ClaWWC+Dc6kLP2CjMO6Y1hUzE7hxPUPUBH+YT58Xk9FR/L+Z81v3
         RZRZKsCRNPqfh29aoeBDmtVGXiJTAkfou2Aqb3vN6Mx+SxV5FkSJXrN5z1hY37eNE8QI
         OkvT5dT5mB1C92tpJkaf5OQgwFoxZpwpZqEg84aF+V9L8JHZ/IWXEfC8S2DS+j1NmeTd
         oiiA==
X-Gm-Message-State: AOJu0YzQQimWExQOlWR5DwiMtq18a/q6tiT1b9y9j9faMrGFuLQoTtox
	48yKH/1bsqdkJQY3MW4XO84o0caesmPt8/9NVceGWM+FrrzqirjqUgZ7ES/C
X-Google-Smtp-Source: AGHT+IGp1ipDOIOHO1uBjxpj+0VleHuTCmqZ6oPFsEH6c3TjGrJiRNAcxMqe1RdU0muse//PBJTBLg==
X-Received: by 2002:a17:907:d91:b0:a77:cb47:7dd3 with SMTP id a640c23a62f3a-a780d3edb85mr293099266b.31.1720559693316;
        Tue, 09 Jul 2024 14:14:53 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc876sm106298966b.5.2024.07.09.14.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 14:14:52 -0700 (PDT)
Message-ID: <06099367-4da5-4777-aace-b5acddbad7b8@gmail.com>
Date: Tue, 9 Jul 2024 23:14:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 Matt Porter <mporter@kernel.crashing.org>
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PROBLEM linux-next]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear all,

On the linux-next vanilla next-20240709 tree, I have attempted the seed KCONFIG_SEED=0xEE7AB52F
which was known from before to trigger various errors in compile and build process.

Though this might seem as contributing to channel noise, Linux refuses to build this config,
treating warnings as errors, using this build line:

$ time nice make W=1 -k -j 36 |& tee ../err-next-20230709-01a.log; date

As I know that the Chief Penguin doesn't like warnings, but I am also aware that there are plenty
left, there seems to be more tedious work ahead to make the compilers happy.

The compiler output is:

drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
drivers/rapidio/rio_cm.c:675:21: error: variable ‘rc’ set but not used [-Werror=unused-but-set-variable]
  675 |                 int rc;
      |                     ^~
cc1: all warnings being treated as errors

   670         /*
   671          * If there are pending requests, insert them into transmit queue
   672          */
   673         if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
   674                 struct tx_req *req, *_req;
 → 675                 int rc;
   676 
   677                 list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
   678                         list_del(&req->node);
   679                         cm->tx_buf[cm->tx_slot] = req->buffer;
 → 680                         rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
   681                                                   req->buffer, req->len);
   682                         kfree(req->buffer);
   683                         kfree(req);
   684 
   685                         ++cm->tx_cnt;
   686                         ++cm->tx_slot;
   687                         cm->tx_slot &= (RIOCM_TX_RING_SIZE - 1);
   688                         if (cm->tx_cnt == RIOCM_TX_RING_SIZE)
   689                                 break;
   690                 }
   691         }
   692 
   693         spin_unlock(&cm->tx_lock);
   694 }

Hope this helps.

Best regards,
Mirsad Todorovac

