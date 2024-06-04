Return-Path: <linux-kernel+bounces-200726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA68FB409
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B0B227E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16614884D;
	Tue,  4 Jun 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZbRn8Ink"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223381487F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508333; cv=none; b=jeRPx6UDmt6OOD03xMWxV/tSs5ma7YJLBYMZhKP8UcCP9erISZlWrDJG5pza33kmPaY/FoWom/khnWNfR+lNbhlL+zaf9ikg6TsFoWNK7ftUhJUTk1DclOdtZ2wZ0JpnbVcnrqUHih8JGOhZqPrMTlFnPFmiuQHi05Bt1/LodAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508333; c=relaxed/simple;
	bh=z061h5N4cOjxp0i0teiEj8YYz0gC70c5q+yIiMSWVlc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhWw7IZ9QWRJJOmNdzwE9HvPS8YNBYzQDzZK8IiEUoPE8r2exmTdRiHMjbtlFDnqB6kXDLOGADhB7qDeB+8XPEVCKHvZ+d7qZgf+FdwwilIInxB05YrafBrWchk9iQWRtjUIpPxnfddLJVafAUyNQvswoNXehK0bNJzQNQatJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZbRn8Ink; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c036a14583so722290a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717508331; x=1718113131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm870wbxwKAXLW/hEbj68HKPTbDqTHobkkHTbGwT1pI=;
        b=ZbRn8InkM/yAq+6lN7nUakNV56FZEUiB8qHHOADHkydqyjliWLjQAhbebFJJmbaqaa
         6xhECJjyt9Vn1saSVSZCn0CKB5x6d0u+0kpV2VqZKFzKu8Mxk2eOFYqg0ovwCbcDlfXi
         alXw0mVtibxY0b0UkPa/Iu+0vxg7fiWtMjrbjQNTL+u5X0+LqVWJnw4mzTMkUMmDCb1k
         FWI/xVeg96JrjAB+UKBC1InO8M87kImYbR1ATZpF/GvBd0dLKoZQnY9+ORjOTMxMKQGU
         FcqaYVRhECHkQ1sdOU3+smFVNx/YyXYFclNSlIdfBgl4Rl3Vk1hABwYwHbNjEfKgz+/z
         casQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508331; x=1718113131;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm870wbxwKAXLW/hEbj68HKPTbDqTHobkkHTbGwT1pI=;
        b=JdBUMlhQhVkvn5u7MK68UOAe9yQ10a6piAacFjpF7swP4yzZEMHE+O2VR68cFUJJFC
         vm8zueu10RVGPgCLwqLp32Nz4yU0CpVTCnipK+LK6rn9QBBFGbVJz0vgjgA/aQcDp5pV
         vsU0Nl21Cm7udsAWO5Mi3A+cqiF4I6lW5NzYzhOox3xDdGMaNLuTyEQwRp+sqztet3/T
         rOtT0yiXDHcGCqOiSWrkbuLD56cLlBNjnWStco0Abqdt1rauzNfwSsP27S086bBSnBNS
         NttPByCFCwciKhUL19SEw26Athd9cWC56m2bNyaiYAHcWWYhgufcIJ5NP4yo2BjCUU1i
         A1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVXoT6LBrJskH+j34SGi/sWPzY63dGRjQUpullyFhWbGSeF4N3ynARghpXB9L8IoDBryaRUXOJxjrVrjQkJT+XbTcjrmfJP1IbET7YH
X-Gm-Message-State: AOJu0YwDAtt4XtEKc6peHQLMT5F2Svn3RWl9C58UwaxfqJ3h6u/mUxa4
	n9RXx1zrhiqdQMLZKjcibN8NVHxx0xTXHL04/TMBsSKoAgp4krw5868ZWBLuSpI=
X-Google-Smtp-Source: AGHT+IFCyPdXOcAxAbUdnZV0B5jNeBKi7NZfc4ouIiei2hl2xFOncL1gQsutNL9dfpsGHk3ZKcIuLw==
X-Received: by 2002:a17:90a:ea86:b0:2b2:4bff:67b7 with SMTP id 98e67ed59e1d1-2c253f1ecabmr2134615a91.3.1717508331353;
        Tue, 04 Jun 2024 06:38:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bab23sm10440745a91.48.2024.06.04.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:38:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Maximilian Heyne <mheyne@amazon.de>, 
 Norbert Manthey <nmanthey@amazon.de>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240604130527.3597-1-hagarhem@amazon.com>
References: <20240604130527.3597-1-hagarhem@amazon.com>
Subject: Re: [PATCH] io_uring: fix possible deadlock in
 io_register_iowq_max_workers()
Message-Id: <171750832945.373240.5340875250569409350.b4-ty@kernel.dk>
Date: Tue, 04 Jun 2024 07:38:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 04 Jun 2024 13:05:27 +0000, Hagar Hemdan wrote:
> The io_register_iowq_max_workers() function calls io_put_sq_data(),
> which acquires the sqd->lock without releasing the uring_lock.
> Similar to the commit 009ad9f0c6ee ("io_uring: drop ctx->uring_lock
> before acquiring sqd->lock"), this can lead to a potential deadlock
> situation.
> 
> To resolve this issue, the uring_lock is released before calling
> io_put_sq_data(), and then it is re-acquired after the function call.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix possible deadlock in io_register_iowq_max_workers()
      commit: a59035de589f31f195ed1fff97007d332552a72b

Best regards,
-- 
Jens Axboe




