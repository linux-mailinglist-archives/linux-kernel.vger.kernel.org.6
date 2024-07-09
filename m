Return-Path: <linux-kernel+bounces-245212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C792AFB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD96B21A03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBFA13664C;
	Tue,  9 Jul 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XpfzJoGI"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A47B3FE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504899; cv=none; b=qOljozDpFD4IKY3Qk1zUxYCCenZ+LOO4zB4OQ5hPjB3ba8VHM/vFjDzEVi6CWZxLDcA6J8iAresOKLMrpxVthHeAoz1SPIbcQCuhFNbV+tdg/Cg4zvz0vkUB2Lg25Z8wfhLJmHlWgDO65m6cM5d36tYVh6mx0YWme4VbAjjKD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504899; c=relaxed/simple;
	bh=GQK4mfK2dj6xYDaGlegfb1xbIlfpMgRKRF3xHgPIecA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DxwW2RHm3JgmV1Y8A0ZfQAbK1qww/FFqWLI+JhPnaZaS3+MWCun4FNemTvaQt8+SPyFYAlJYiUmMP6dEbCjkBFE8DBgqr/ATtRagNVniGwEfvIqTXd/UAdJOudBG3GtmU7DxCU9cDhSlAIeevD7Hzeq5CD6+F7FxMcwZt0jvF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XpfzJoGI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eea0cbc96bso2024431fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720504896; x=1721109696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpEXxs/a3JbKNp7z3TVbrm1r6OVOY9ogohJN0enSvrg=;
        b=XpfzJoGIfhQ9w92MXXwYFLJYgbSrx4W8UYrslTP6/Qlj3CS3nOXVc80r4tvK9cKpVh
         gDIqS55JpPiLli1Qfi2wtd++YhV7uojHrTxNr13MolVOH0iJETqU2vtOvxKmYhTUoCtj
         PS7iZfN50VfgOQo213pEqsm3qTcZ8P+WfECein95f3ZxVqskchzUu7spOKFEinRyFzHq
         1Sm56ih+rDwJgor47PjY1CtL6atzFk1hvzIyWrblVLsaUHjbwc7Nke38MmFCfTbVpGv/
         Eu+lwNGctiFRn63GFFKrAsPVr1kPqutaY1TRA1i3mdtOo/PI3Tb3AUQglGm/RHStMGvB
         ArkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720504896; x=1721109696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpEXxs/a3JbKNp7z3TVbrm1r6OVOY9ogohJN0enSvrg=;
        b=I5VopgYSChFFL2yZDYz9+AFD0VTXT91UkLWy/MVF+GqlcoB8/gnDj/RkTvspy7nLBz
         o1rR92JvPeUrfV3gTTj6+PrTifhVc8oDbSHr0s7ic/h/HnAVwl6pN8RRZeFg0Gt2WcQ/
         dwA3oRrJ9WOviPUvDp26CJUmqKxKphV17sQxvmmVb3Nn67VKaUqbN4l9bkktFqDzzFVd
         Tyx2lrc/cOCDxGsB+ibSK5zgjIiCPFbpICWQ1okyakbj1mvMcScWj79OPvecatgmd0kG
         x6xpUe7joiu2Tgr2QuZjvg4dzl2dsY6yFdyAXeW4aS5imymYOIfCrjE9kgyEIsmI4Z0Y
         NIBw==
X-Forwarded-Encrypted: i=1; AJvYcCV/RzFYcHV62/Cyv79nEIM7VEC9T26IojqwtppjufZf2aUVWLN69zlF881kN17eEIWp2orS6jnCLschzdrWPsUEiYNRo9pAN3PqrMUs
X-Gm-Message-State: AOJu0Yzw3PRFaDfs5MOP/uOIDoVuWJU/xEIR7OBMnU6IwwAaqTCnr6hC
	BId1AMud3vp/PaeSvHV4+jz7FER+vZ7CVDUBouLHawhnAfjVZUfdlfqvgw5qIgQ=
X-Google-Smtp-Source: AGHT+IHQnuwy35QWEiBtYIJ1SNCYiPZUVvr4X2KGvjt0Tnviktb5lh7srF63/f8/KiU5FIC0a8dehA==
X-Received: by 2002:a05:651c:509:b0:2ee:7e6c:34d7 with SMTP id 38308e7fff4ca-2eeb30b86b4mr11002531fa.1.1720504895382;
        Mon, 08 Jul 2024 23:01:35 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb34338b1sm1133741fa.67.2024.07.08.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:01:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, 
 kbusch@kernel.org, hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v2 0/5] Validate logical block size in
 blk_validate_limits()
Message-Id: <172050489409.367933.1302636222826369855.b4-ty@kernel.dk>
Date: Tue, 09 Jul 2024 00:01:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Mon, 08 Jul 2024 09:16:46 +0000, John Garry wrote:
> This series adds validation of the logical block size in
> blk_validate_limits().
> 
> Some drivers had already been validating this themselves. As such, we can
> mostly drop that driver validation.
> 
> nbd is problematic, as we cannot only change to just stop calling
> blk_validate_limits(). This is because the LBS is updated in a 2-stage
> process:
> a. update block size in the driver and validate
> b. update queue limits
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: Fix default logical block size fallback
      commit: 4ff3d01275dee10ed1f40c314ba5133e3c7a6e1b
[2/5] block: Validate logical block size in blk_validate_limits()
      commit: fe3d508ba95bc63adba661355115be340275c0d1
[3/5] null_blk: Don't bother validating blocksize
      commit: addc3a68de850fa25dcf937705e721d8eec22470
[4/5] virtio_blk: Don't bother validating blocksize
      commit: af2817229158cea7960b9132e0a8c4470ebbfef5
[5/5] loop: Don't bother validating blocksize
      commit: 9423c653fe611070d875b374fb322dc44acce3f2

Best regards,
-- 
Jens Axboe




