Return-Path: <linux-kernel+bounces-227122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518F91489D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0197A2844A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D9139D16;
	Mon, 24 Jun 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="CYviNRgQ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309313210F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228449; cv=none; b=qYndkWOJ4b8xjcjnflULiBGu60gD/56YfU7OEbeKhzgH/abY0eFMLPCsrgKKScrnrr/F66DJ6Ba+FNVhsB5+yp0jRz0OMA0VNECf9yXBHkNXXlyZjWg0mmyzPJisOPaQjbpppHAhB3pKfwARoDpJWhT7qZe9sAj88bOXX1mAELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228449; c=relaxed/simple;
	bh=+ErZu25pzqLlx0hslTTrxNR30qs/NYpfkUirTISVxhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js9sXn10sQbtfC4Q+LSFu4aCrEvdGEhZRnRr71z2uFyl76xlKm54kEvYcOlU07GJNzLlOu4YTuIMEP4K10axZRiJuzGEJFaJ2Ze5kL8zArW4lptNTBLuAIagkLorKRFrh/HKRsQMu35XiyoefDE0OXPY/NykhYge6pr3xMDKDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=CYviNRgQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so3216353f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1719228446; x=1719833246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ErZu25pzqLlx0hslTTrxNR30qs/NYpfkUirTISVxhg=;
        b=CYviNRgQUPqG3rMhItsHTnYaFcPZEWlj/17p7dj58a+jOCOQn1BjBukKfO5uvCXtXw
         WsCBWl/PvXadxEEepMcXI3sStSNIzIX/vkZ2pW+0+ikOO+q9H8/XTnFnNQQgfA6BBLH6
         /GAfH3C5sILvnf/eSMjwCgcmDmBTm69KfPlAdRedQlMnwhwsR4XFNH/Q48ga8HE9c0s1
         F/z6VmAsFrCLzOp+Btep996naTpl4ML96ZCHRUs199psO4WCC3Ydu7u6qyzdzklVujZ6
         VTIVgY/G+wr+FRbxYgnQjSR7KGfLQcS7SbWwv5HIxHkqMX7kH+0DIkJSo8pyby3daxd0
         5lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228446; x=1719833246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ErZu25pzqLlx0hslTTrxNR30qs/NYpfkUirTISVxhg=;
        b=eX2hwdpjppLHeoooeeN4dbyPNTzI+6wqiUMetSOC3u5VL50IlaSf0OJ2cNp0bIbFyL
         Ik1QxiAqmEgcWAz/yabLBZwD4wFo/pFE4dPH7vN+HDrul3FPc+pKB0H8YvrbRAEjb+WE
         vZiG6RLm+t5aB/avo++5aCHcXWSaXfVYwuCZxe3PLeKG2cmL+ZJBxqDZp7NCEWEwjicG
         c1pdugNjxrc0VjPqMSmJ7EpifAAof7ggNnYuJKCx4Lrfc6PL4ldwRTZrY6bvbC7v42Oi
         LLrMPvfeBNq3bHEqsnIEPIzMUc0/V7jYJSBBrtrxuLjpALyAZI85KiGHIcCg9Rnwosby
         SjnA==
X-Forwarded-Encrypted: i=1; AJvYcCVU2dv8Dts2vz+PW4HSd1nCR6PSUpjR6ir+t8OyVTrgkUHDEUBvfbulcUKus0NorYAtEjlWtQsK8PlXEyXiMGgBz+TSSiUhXA7SH6Nk
X-Gm-Message-State: AOJu0Yym7sUOCpQkOQ+hW1ZWxAlETrTHBQwUHENd5udG0OOMXw+vyLCQ
	VMLX8vCC4VfTLEsvzhbXfDhNNtaMkAuW6/FeOJ1DXeBOFr2N8vUPeYuEA3qQWbQ=
X-Google-Smtp-Source: AGHT+IFWP5JEehjY69pBjz0WQ3anDW4CngvKUSqHMOwZQlqaLIx6z5C6tmyfHa/ydbDvB++TnaXu9Q==
X-Received: by 2002:a05:6000:110d:b0:363:d234:c790 with SMTP id ffacd0b85a97d-366e332e1eemr4408123f8f.29.1719228445715;
        Mon, 24 Jun 2024 04:27:25 -0700 (PDT)
Received: from nb152.localdomain ([167.98.108.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191c65asm130149825e9.40.2024.06.24.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:27:25 -0700 (PDT)
From: Stuart Menefy <stuart.menefy@codasip.com>
To: alexghiti@rivosinc.com
Cc: aou@eecs.berkeley.edu,
	bjorn@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	Stuart Menefy <stuart.menefy@codasip.com>
Subject: [PATCH] riscv: Extend sv39 linear mapping max size to 128G
Date: Mon, 24 Jun 2024 12:27:07 +0100
Message-ID: <20240624112707.2183752-1-stuart.menefy@codasip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240514133614.87813-1-alexghiti@rivosinc.com>
References: <20240514133614.87813-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexandre Ghiti <alexghiti@rivosinc.com> writes:
> This harmonizes all virtual addressing modes which can now all map
> (PGDIR_SIZE * PTRS_PER_PGD) / 4 of physical memory.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Stuart Menefy <stuart.menefy@codasip.com>


