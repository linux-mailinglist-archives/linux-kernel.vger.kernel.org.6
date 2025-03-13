Return-Path: <linux-kernel+bounces-559594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89247A5F5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1917C188CA81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43652267AF4;
	Thu, 13 Mar 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CgRsHjrX"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3970267713
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872282; cv=none; b=iVrT5zdfIoTWbyKR3Er2WQZjaPx9y1rShPb2c/SzyGERsb4c/OnTvcljfkye9qh+RiS3501WFyh/DGk52J7Vm8FSNoimIlGeUpxr0rUJ7Ouyme8CqVzTm6KKlG/JC1Nb2IzOdlVFRoFndC1PXHhZK+q4A7N/BYIseA6yFq1prnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872282; c=relaxed/simple;
	bh=oxBvzwvTrG82n8EJbBWNJ307/ROiMAIN3ZDd1Xbf3ig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YzWRZj1PSca/MSQUN9uM86aw4iPSSoQUTOKeWfjJEPTIKs7E0GykfTQgcGYxNOqmKtuWyhMsTe4+7vN0aNMCQ2LIucem+T25wrQFQ/bmmQr0q+oKin7NT68qDY+IBZDXZsZ78WXcUlZBzU1t9Y+5bG3NCPr+jyOds+BxMIyGuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CgRsHjrX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ad83ba141so95368239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741872280; x=1742477080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=CgRsHjrXXRqq4vaPHAcHpS5QmNOKwPbwPx1qON250R6Zi2OYgAUJ+uhFKQuGASSWQm
         rS7BY/yLPqLiuDxkl1/pXv7VWbJ7vDEGxpDH6GcG6/dLYajQjZHTa8KbZ+qumNySbDVQ
         gz6YNnTe5EHVHnU/j+EU4aBDLYuPhD9jw0fqBgZkqKCCOAEfIOt1oGRotT9X1Ju/lCix
         1bBdnCrP7jcTTY79NVlC35F9pvq8RTo3qnAo1c2m5X5xGbeUAbZETRvWLoKC6dh7aE6e
         gLjgAv/qJFO5MTjp5mpC15RwBUcg8FbdNu6RlZel9/kWcHOY+Vi/o8qQR9Lpa2KJ1yXT
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872280; x=1742477080;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=XYFJiZ1kfKvBZevs9khV6xVamKK4ql4pckTZzRxFj2a4s8eyeKc1/pAd+t0oBtAbpv
         kmqjLNJjpr3nqPz4TT2v4x7iekaGrkymsHuoVwfgwWktupR4ki7Y/Rcj0Cx60b5lKdx5
         2v1u7s0QEfvPNt4Rk/8Jo52oFEQTdDiXty6VLPO1v4WsUg5S5dKIiILkbhPmQx4X9EGR
         kTlF8OVJYy+tZqGagNuUHLLDJfmJDt1AcRMauH2KdUOjvQ6US7F5QnpJPVj4S+KM5mh0
         /hPdbmDvrJ8trOiNFE8zIYggtx6s6Ykh8rFMFdJ7lPInW+Ku8Boqk14ucRofzzUZ+Ati
         1lQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Jlo+rOs/40RM5uhqpCCSClsFk6HS5/ieP1ED/9yyPxncCvf9tF2b5IgjhvcNT50ot/cICVqLfYFOWbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQQL2nCPnzbKIlH4lNGI5b824GvSVvW2qq2yUzDiQeLSEjf29
	vkQsiHCPkd3YvzRc2ctdz/ihyNfF3YOXCYvVc2BquG083mUW0zYMdmDEfYh/Vns=
X-Gm-Gg: ASbGncshvV22/kwS6BwHeqrEeBIR9fjocMkHRU16mPLqmi6vQNqmT1kl3o4bnmoW+VA
	i+dffHHAQpybGlUpvR7hKDwa4t1S0kL2F/Q+rUOW57U2lGuCEY9+N/yI3UcuWiMHp6KZ9gdMDZg
	H+2J4mTNEtdOG1tKs8yhdIbFj8uVLFnomGB3CPCPlItZZh/BmZsKO+PZ3rQoyqF4ztgyZSgzjnE
	9B6yAurWodfURk0W8zjRsV38U2vhGWwp7uYcVmK9gpPPRUm6tZ5PgCTil/DKuRXx0tPI1iWwh7E
	p811lQ3yeD0CImptuLhFNIp2RoUgrtAmCJQ=
X-Google-Smtp-Source: AGHT+IEer637uehs/daevOydns9iUer0NF8/Lop3Ui7LDoPjH6cMpb131IF3qkXQqxQNFL57dNEHAg==
X-Received: by 2002:a05:6602:380d:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85b54946d71mr1891701439f.5.1741872279762;
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879e512sm31580739f.28.2025.03.13.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250313035322.243239-1-anuj20.g@samsung.com>
References: <CGME20250313040150epcas5p347f94dac34fd2946dea51049559ee1de@epcas5p3.samsung.com>
 <20250313035322.243239-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: remove unused parameter
Message-Id: <174187227786.18244.14269218969550436496.b4-ty@kernel.dk>
Date: Thu, 13 Mar 2025 07:24:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 13 Mar 2025 09:23:18 +0530, Anuj Gupta wrote:
> request_queue param is not used by blk_rq_map_sg and __blk_rq_map_sg.
> remove it.
> 
> 

Applied, thanks!

[1/1] block: remove unused parameter
      commit: 61667cb6644f6fb01eb8baa928e381c016b5ed7b

Best regards,
-- 
Jens Axboe




