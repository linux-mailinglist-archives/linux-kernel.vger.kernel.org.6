Return-Path: <linux-kernel+bounces-235295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76A91D306
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF973B20D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A212C6A3;
	Sun, 30 Jun 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2j7ETf5"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38B12D1F1
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719767593; cv=none; b=L7i4O4cGekFvdm3cwfV3xiQDYIpphohRoPtHxG/W4/mKX52rdabqQOc8iFE0/Qb4O5QtRTxL7mAV9lTUh6EU4xoLL8ITLbzNg3LhUZMcOSJfNoQqvD00buuDv+5uUKmbm8PPht84hfPGbzCCOxWwS/BRi/hTJCzrEGeffNEVFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719767593; c=relaxed/simple;
	bh=Qvyy3/lXwyEKWXW3eZp7oyXDjXCqcmUmVrNjAO+0GB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y24meo2feUIxbmt3agEdkTbmb2fM7yM30xHtehCyAs5KUWiLVMv5fbBBQ4bWM4QRmsypfVZNt2X54wJTROwIhHKA2TdV+F2vIWGyPjp5lXiWKypoUiXaTMQ09XlGWLEk4TGEmhziRorjfjg/pcKJNytWJrsGhn2VEcrEoPVgbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2j7ETf5; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f6309e9f29so49563339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719767591; x=1720372391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TlkErQpa0xa7YZ2T83OsxknNGSqMh+VvQCwH5wNmHY=;
        b=l2j7ETf5bxi3vmqCt6n77r2L05KLHwm1e1m1anGaJiGHDbIv9mwAjTfnZWMRXlUzt7
         Mf/UJJXRS5TjDv6BzNr4kRGBV4gMzc9uPe4goUvlyWf/lqWs1Xx90Bygay6IkmtgWXPh
         WwQ5+N4AbA88smfga6WRhav0hHQo3YKj0/TxWp/GziknVI1Cpl6sLEzcV7IrcqnxQSB0
         yOYHA/QpawksMTBdzF4uVVvQYwJu2s3Ji2mO5r0l6lo3XRuVx8eusBVkWVdfzO5vrB4s
         E7qo2Y5vq0DgtvuRRBwf+3CpAiUNCDEsXHiK/D+wX7KZTOcinU3+qhvEpKC20zkZKYhl
         lSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719767591; x=1720372391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TlkErQpa0xa7YZ2T83OsxknNGSqMh+VvQCwH5wNmHY=;
        b=oAT5ppn+gFMYJebHRNfrsiX4dfnJN2BqXtj3lwR1SOM2wqzIiYejzkvLgSsZXLhfFm
         Wz4a0nT+khSJB4LtfRzAJ9+H4wcw4w5jEr+O4xEEW76JyUZtQaNre5fxFrJjCumEl9+G
         Fb93mgOjRtKe4sgQCSspDrm4TfUo4ioVNZ9QnU2frLMYoSO9oy4e3mZNjfRp2kk4lRKw
         ZFl0LHuOuDtqpmlqBb0SnBf6B4FGpZTGdit06XQCtQyMLpgwMwScjo8VSRMBl8EVqw5r
         VWpr1TrB6/R1PiZ4qNjFqxLjKhm6mtTrplAY1V8RW3AOB2vHGnmmZLci9WhB+mZPRgAv
         wL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdOuvVfUmtC/0jKv/syhnwWPapkyUxfgdwk/WX0fzcmNez0AyPTB/7uXMW2wCD+g9a4DQ9ZDir/1axpRjLUxa9KsE0UvzEEkF/vizT
X-Gm-Message-State: AOJu0YyBU2Q2WNT/u2A8vzf150MQOEAtSDqdmRWb7/xuYmHt46vpweRC
	50GAX5BtN+rhnCbmAbnzma5BhEJcJyyLJasQQmXbWbTSmBsl5Ei9
X-Google-Smtp-Source: AGHT+IHL5QOdEfhGtEp4jRiJ9wOspdZ3OAW2+SZYHN4iHgTZ+RSxfUJigxeqU9GpA9qg3ovx2PO/Ow==
X-Received: by 2002:a6b:7314:0:b0:7f6:1f20:f136 with SMTP id ca18e2360f4ac-7f62ee7a0cbmr443659739f.19.1719767591625;
        Sun, 30 Jun 2024 10:13:11 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a7e5cd2sm3894217a12.28.2024.06.30.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:13:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 30 Jun 2024 07:13:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Laurence Oberman <loberman@redhat.com>,
	Jonathan Brassow <jbrassow@redhat.com>,
	Ming Lei <minlei@redhat.com>, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: dm-crypt performance regression due to workqueue changes
Message-ID: <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>

Hello,

On Sat, Jun 29, 2024 at 08:15:56PM +0200, Mikulas Patocka wrote:
> With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
> 
> The reason is that virt-manager by default sets up a topology where we 
> have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue 
> patch avoids moving work items across sockets, so it processes all 
> encryption work only on one virtual CPU.
> 
> The performance degradation may be fixed with "echo 'system'
> >/sys/module/workqueue/parameters/default_affinity_scope" - but it is 
> regression anyway, as many users don't know about this option.
> 
> How should we fix it? There are several options:
> 1. revert back to 'numa' affinity
> 2. revert to 'numa' affinity only if we are in a virtual machine
> 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
> 4. any other solution?

Do you happen to know why libvirt is doing that? There are many other
implications to configuring the system that way and I don't think we want to
design kernel behaviors to suit topology information fed to VMs which can be
arbitrary.

Thanks.

-- 
tejun

