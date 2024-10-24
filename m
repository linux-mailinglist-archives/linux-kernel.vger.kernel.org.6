Return-Path: <linux-kernel+bounces-380686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803159AF48E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B07281696
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AA2178E0;
	Thu, 24 Oct 2024 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="E04oyj/n"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD31ACDED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804462; cv=none; b=k7Hb1RVpc3gZudcMG/sRR89DBtmT3/igxP0BAgfywcd0+dMYqeu57r5r54jV+drZsq4w/TQyEiymW1dtX8yKVAFRta9yvsDllVy+nqERjS5CRbHzEID2ipPwga3beZOkFh0erkmgkz5vgp3nPAe2GDKopU4B2cGp2iR36oCfSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804462; c=relaxed/simple;
	bh=rCWo4AEZm1UWnEuWWDbCGjSYu2CiVU93lvL0UlLuZq0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=CRNjyFCFoDh54YfRXfi5sCm0qIKQuP3A0plaQ7C9Br9ipI6qhSIvxL2Rf6wMbWa1ijLhqmU/c96BanYCb3xiD85fz7BRUnavLfzLkjEw1Uoz1eq3j945MxSdd5yUj20rK3RVe9Zu4B97qgMvFE4mTv5NgQKOwd7MBSsQ5CdrdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=E04oyj/n; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so984071a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729804458; x=1730409258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiJbyHkpa/rD5fDWUJqjFih69lFbISgDjEDgatp+bhk=;
        b=E04oyj/nUwxFDG6JtAOoIrNXAjhc+b9fSl5GCWG1pXXFWBo3AeiVIRM49jfezBlgW5
         C1FpgbVw64Ym53bxTYDbr+L8n+mvQq0jFeYlzrkxJqDwSfQSgLOq0zLmmCm0E1HbtYmK
         g00G9fhjbWDlgsgVczAzlv5GfKFRP86bepo+/PIGYgqu4N7gXY/D3p3cW1C22x7JuJLE
         8vZ3cvPhLz5bOIa71faUg0k0eTcAD1qA2cYWZanA1nNEB6X61/6qEguzYzfkKs6kSlkm
         vFBvd6UYA9MuCGRberFLy1suYS86G3VKcwvLACi82ZDPQ9vVCq66e5a4hZJSZ14SC5YG
         arow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804458; x=1730409258;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiJbyHkpa/rD5fDWUJqjFih69lFbISgDjEDgatp+bhk=;
        b=e9fo45rFfWGFZ8lwYEDaeez5LwfXbB/v294HQXGpchlJfnqRl5sCCZrlufF0bZCfsL
         J0iEyBISELPn6yQ6B6SxFSPkRYPcnA7jrUa58H7DhwVmf7gnKVrxHb8LKhdtEgDRRGy0
         unremGYpIVLVj9f+ZOZ+PkuTTJrfPEFn0/f5G+AcIfTkY2NG0Tf6oZrew26DoCTGou6j
         e+SFR6lXAP6mzsUp1IoC6UffwVe2QCV/VFZruRUW9AME5XvD8XdzfCL+zRFegRhUd80d
         t4s7iFyIS7boaKgQAulwnDj8zCkaZQXLccbozRNrh1uC5BgecQ2Bg0W6CDF6FQiMKnvz
         +8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWpMZXbtVurPhGLdTcBhnGSHW1PmM3wlNwILtFeXd0lNFfDbaSHe9IOn+2meN41AGod1rffa8yVXo0KUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1sWmkX2caYPXphpYrk/a662HXL6ZrrM95gXnVVdxUTleujQS
	neykK5qBUlFXoQXtJ2dTEtUW5Iu9KtcZxAi/fv83C9XDmnmAcigyCAPQMGYV/m+o15v97P3+gHd
	7
X-Google-Smtp-Source: AGHT+IExxVdLxb0EnGXeM9uQWuYp1Z31moAXdVKRy0/68mQvvpnpPMGCMSpxRAeKSBwWk9PYSDKZkw==
X-Received: by 2002:a17:90b:3b50:b0:2e2:a96c:f009 with SMTP id 98e67ed59e1d1-2e76b5dde45mr7947043a91.9.1729804458375;
        Thu, 24 Oct 2024 14:14:18 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e5a321dsm1972316a91.53.2024.10.24.14.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:14:17 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:14:17 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Oct 2024 14:14:15 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20241025080355.34c62c4a@canb.auug.org.au>
CC: Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
  linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-3386c07e-d82c-485e-b12e-4a44f1c3b893@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 14:03:55 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   814779461d84 ("KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test")
>   e27f468bcf14 ("RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests")
>   d250050aae4f ("riscv: hwprobe: Export the Supm ISA extension")
>   5e9f1ee1c523 ("riscv: selftests: Add a pointer masking test")
>   cebce87fb04e ("riscv: Allow ptrace control of the tagged address ABI")
>   c4d16116bd11 ("riscv: Add support for the tagged address ABI")
>   871aba681a0d ("riscv: Add support for userspace pointer masking")
>   1edd6226877b ("riscv: Add CSR definitions for pointer masking")
>   12749546293e ("riscv: Add ISA extension parsing for pointer masking")
>   8946ad26c0e2 ("dt-bindings: riscv: Add pointer masking ISA extensions")
>
> are missing a Signed-off-by from their committers.

Sorry about that, looks like I missed the `-lts` arguments to b4.  
Should be fixed.

