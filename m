Return-Path: <linux-kernel+bounces-366177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1899F1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D75A1C21EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C0F1F6682;
	Tue, 15 Oct 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8O1kYdP"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71771B393B;
	Tue, 15 Oct 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006996; cv=none; b=PmJ92/c4pzME32Jxa+Otrsk7NY0jF+A7+VnKkSbRdPYxkqdiMfGldC08r3DXMTXCGmijIqvAin9xQUj/FMCMtrKebAD8Wyp53Tz8NmjJR93g1rZegv72XbFcvM9+yU6bX8O0BzYltQzSWGJza80QqP1bOgrOdxCMPUb5uz/cTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006996; c=relaxed/simple;
	bh=fvq3i1qjJoQIOivp3/oPr2+TjZggBoO/uU5HFAef20g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H3+IvAIUp8j+KenKqIN1CMEwXtNLYxNgYgOREiFkLZDgITDzq3aeDs2LjzZ5zUSBCR/AtFJJ+6NcVVNrg5i/Q22QsvSx+8cFP6sq8ibMw0JDg4U6oMG5wM0Vj0rbmqX3ehD1TyLXlZcsXFtiOKfrQ2CaG5vI1tnS67Sg3W8JVj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8O1kYdP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2ab5bbc01so964746a91.2;
        Tue, 15 Oct 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006993; x=1729611793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qt/WVF0arB+9ZJLOPjOzNmC1wW2RLJ2NDETDlSSsn0=;
        b=k8O1kYdPAznSLaF3SgZcY5Kz77ND7XN8rkJ6HViLG9B9FnrzbFIOhduPZwdLZp4DyV
         GC87K+y3W7+2S5W/dprQXg0GrhrZ/UxvrzSIqB1C22BlAdf78ShcxGAR9zKJvG5akuO0
         eXJyprk0WnbBJbIvkt9tYskiQwL/yPea39tXVx+udb/PDvnxjjREtR5xopKbrxVAnhn9
         7X1Zw/R95+jY6r5VvKbvoNLDYF9EuCl55+JwuhSarQb5mo8bNZwLKWUQXKczyBAmipEc
         sP08luiAlq5siJ12fWfeQpOtmqEKmYWQi1YLIcjFyxVr/e12zJQauMCaWEvn2CkaIIvH
         o77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006993; x=1729611793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qt/WVF0arB+9ZJLOPjOzNmC1wW2RLJ2NDETDlSSsn0=;
        b=hpmt0Ibgd4hoeRDj7FN070bzw4YIJ/dVMi66+5fG624xlGX3P8x1Fxxd669hTAb0Uw
         +QInFf0CjgY8qhWFafwonpJDV0/3GhP17X6yHA1hTtja7KwB70kBSlPL9ep70DOum9jE
         mdOXzzEBVZQ+mwOkH0Q/eM7eGqKr9nZtm9Y29QDbaVUJhIr7r+Zu4Vm1+XgabZyKCSE1
         N5PsuJE/dGVZkvsSmuXZ4mva+qVHFUOP6ygrjXmgyHIDk8pMg1V+l4E1wk6LyqsZuDCk
         zCrUN60PlzfuMCBiWtDXkzgraeKNgq/n2W9I/jkjro7t3/vh4FLNMJaJdtyKJYP4r0Kt
         TzZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJpHPRoLqQY3GjohUKvhVLp5MvW9ZEwJ9Ulv31ZnfV2rfSjgMOy7R+5e9dj1ONKG0Mwm4lyvoWPq/oSis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynq5L6X2y+Ac3tnRlL/fXqbCw/zily4NJu+vXVByWQpVHrsaaL
	6Quh0vWhu4dVCuRntgQS/EsQM+rjdGR0Dvb0CBbSAL2jAViKxWmn
X-Google-Smtp-Source: AGHT+IEG5dfbGTDfy3De6vfVI6Nd7s/Wg5BEunS/lb/Z08CscAe2SSHJzfUOiR6sPWKfHRJ7Uz8E0A==
X-Received: by 2002:a17:90a:1b88:b0:2e2:abab:c456 with SMTP id 98e67ed59e1d1-2e2f09beda8mr7674186a91.1.1729006993040;
        Tue, 15 Oct 2024 08:43:13 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f655fesm1945669a91.38.2024.10.15.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:43:12 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev
Subject: Re: [PATCH v5 1/3] Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
Date: Tue, 15 Oct 2024 23:43:01 +0800
Message-Id: <20241015154301.4736-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yanteng

>> +随着内存容量的增加，久而久之层级结构逐渐加深。Linux 最初使用 4KB 页面和一个名为
>> +`swapper_pg_dir` 的页表，该页表拥有 1024 个条目(entries)，覆盖 4MB 的内存，
>> +事实上Torvald 的第一台计算机正好就有 4MB 物理内存。条目在这张表中被称为 *PTE*:s
>> +- 页表条目(page table entries)。
>
>page table entries -> 页表项。 So:
>每一个页表项在这张表中被称为 *PTE*:s
>
>> +
>> +软件页表层级结构反映了页表硬件已经变得分层化的事实，而这种分层化的目的是为了节省
>> +页表内存并加快地址映射速度。
>> +
>> +当然，人们可以想象一张拥有大量条目的单一线性的页表将整个内存分为一个个页。而且，
>Hmm， let's exec %s/条目/页表项 in vim.

This translation is indeed the most confusing part for me. When 'entry' appears
on its own, I previously tended to translate it as '表项'.  However, I noticed
that other Chinese documents have used '条目', so I reused their translation.
In our context, though, I believe 'page table entries' and 'entry' are better
translated as'页表项' and '表项' respectively.

How about exec s/页表条目/页表项 and s/条目/表项.

Thanks,
Pengyu

