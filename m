Return-Path: <linux-kernel+bounces-566273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31EDA675B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D30317D3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734D20D4EF;
	Tue, 18 Mar 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Dh4QxxHI"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426AD20D4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306276; cv=none; b=s0v9PXo7ddePzJdpVaL77ounqZzBlkPWxhXoUQ2BQfT/48y1b3HLwHwlVNkNdiBvwJLHEpqAJDcb8Jdl4sXER+yYYZUsFyGQUZpiWMzIP8mtsS8y/zD6kt3sb4jlH283cDr9GspHjN9fGoE970zqdfmw5z1l75m+eAAMS4Pb0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306276; c=relaxed/simple;
	bh=xb9WdjxEexZgfM3k9ipu2MTXGp6eGcSVjAkjuBZVpDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hGSkvnCHAXHlSxXvGTMJv4gDoNlSTBdr1HFhb+/5EIcExtr4QCXYObru3uYp4ZAQADBFxuXxaiYRfeOm0lPoH2Bi1tu7482fiu8sgPy5S1A4y/RQOR1Uy5ojA+dNXeRJWSg/r3KWLo78SelCWnzUntojhP4kCXkfzTu4knsTZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Dh4QxxHI; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d43c972616so17829205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742306269; x=1742911069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvOvbmR6NQGDjpnSfgt+13JThVeAb9e7iy1G9pfLmLg=;
        b=Dh4QxxHI90PZmq3mqp1LNPe1F/TjnZyFMsOPKlUGfHl5YkXCWkytWN1GIxq/5az46T
         yhLuvnqC+D+UfXEvHmP9jegLIVESPWs6xVRb4dyedPagQUViZhX5izUHn8UiYBANkMCZ
         jvqYM4tL8IVefYwMdH+if4xxjRDpiJ3mr8pHhICOvZ3Hm5Bpg4KoOBIK4zg0sLtjC54B
         8NP0AKZ7OS9cpEdHkYF4uHu+3Ijk8k8GJFUWvIGEzI5Tg6+W/wwjlhtMcAONDG+miw+x
         YqdaznaZydvctcrQAWZy+Q8siR6iSeNHlOvqD9VCtlq6PxCgObspDNcinjD0FxejXS6H
         qAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306269; x=1742911069;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvOvbmR6NQGDjpnSfgt+13JThVeAb9e7iy1G9pfLmLg=;
        b=OQnPvGoKOVnVdut/1UxuMMG0EvGACnD5j38ZOiLPB4cjlyUR9ob0m+2IDcBnCKuTRR
         4/Fu1fEHF+AGJ1ZEXIawUSUmEXFPF/AOxUoi99425FLUeqrkE3Pzm076xpSLYbO752E9
         k8SqCmXA36p1efdwc+ntpP9dVNTdYBZ7VSDujbJIiqMh+rAlg0iPE/Yye6aD6sU1uWfw
         Kbyhw/Yl4FPGe9RbP3wYwOH88pPlbp5/VGToRw0/1TquNEQEUTqDxt9nobCK3lOTyuTn
         OkLNLIU22RIW+hmT/nPQsjprZFE0NbzIss0K6aV7OhVWXBcPSyz07D6Els0zOGFQlsDb
         QqBw==
X-Forwarded-Encrypted: i=1; AJvYcCVlbbJGVURuaT9NKd6prhOfkH2M952PPcLG7ORoggS7V5/jMFYct9uGAVQEF+wePafeR7GdmkPHmqJI9C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZ04i38NoQy4su6b3RDrgDVqoPg4OhJ3urNKsy5yLzJJ1Hhap
	/KrMnXDTDbjIrM5Jo37rB8sW66qT2tZdtca3fnYrb+fp6hIHk0z3fluh+efclVE=
X-Gm-Gg: ASbGnct2jLQY2u6nje1PLCrjGwvushw0x3tjuGvu8eDitaa25Ni1pPGHgBDYR93bRu/
	VW5/tkn4PkUSKbh3LXQlKB2eQ8dKiUonrahNipRH7hWga6KmXmot/LJ6rTIp5bU+pHL1yikWWGS
	flN15PwU5w34HgXNsfmLQA7FzjeJy7zsDDL2tOnKUcdo+zn22CKTnHcimFlfvOutfzfN70VQM/D
	tUmaT7XHJAgadckWXRiPPDaahZMMhpWRqPcH6j83n43fxqWMSoe9a1IflQWKkKv/0epELTp7Pd7
	OlkeDM4j7RJFHfUrV/DARBINMHFH0fI0i9qf
X-Google-Smtp-Source: AGHT+IHSTo4Yxz6Emmj8UDXdqlLkVwyU5EQE7l7BjFEzrVx83+66mTGmPpOgNmV8CQE+A9DapoJXMw==
X-Received: by 2002:a92:d14d:0:b0:3d1:9bca:cf28 with SMTP id e9e14a558f8ab-3d57c4330femr28485225ab.8.1742306269307;
        Tue, 18 Mar 2025 06:57:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2638147e4sm2747321173.115.2025.03.18.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:57:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>
References: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2] block: Make request_queue lockdep splats show up
 earlier
Message-Id: <174230626857.125116.10538016841387488371.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 07:57:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 18 Mar 2025 10:55:48 +0100, Thomas Hellström wrote:
> In recent kernels, there are lockdep splats around the
> struct request_queue::io_lockdep_map, similar to [1], but they
> typically don't show up until reclaim with writeback happens.
> 
> Having multiple kernel versions released with a known risc of kernel
> deadlock during reclaim writeback should IMHO be addressed and
> backported to -stable with the highest priority.
> 
> [...]

Applied, thanks!

[1/1] block: Make request_queue lockdep splats show up earlier
      commit: ffa1e7ada456087c2402b37cd6b2863ced29aff0

Best regards,
-- 
Jens Axboe




