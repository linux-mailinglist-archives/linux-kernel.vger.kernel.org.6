Return-Path: <linux-kernel+bounces-178228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F48C8C4ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4409286B43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37C17CD;
	Tue, 14 May 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IRTRWiz8"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288CEC5
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648599; cv=none; b=c4KqoHC3eFYZ/oIWo92LWPXtt2RJaEwtqTax8R8gqtOmLDsgd7GYJrz2onY1RlXJ0glV3Hci8lRBzl0jF09bAbQSiMxrONMUWvuyVhkxzRMPiStt4lnZ8dnjJVm54rXWCQu8WnaRGU0xsfNsivD9RxObmsAnA1RRHbMQieFTDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648599; c=relaxed/simple;
	bh=7dQLwwE3ln7On0AlPEwJlYxpqrpUlDJ5OpTLUT6s5YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhokjgnrDmJOg3+gqU4J5SEJDet6XqOjcIBFR6JmtWSZVTb5Bh81KfHy5FyTMqhMwD/mraWZihG1nsd3xvCNhq4LxSduG3N74IfrY1vK3qRRfjJff4B0Z99GxQjRAyeq4b1PxuprxZNeUZHzar5XVIDG25elNm6hZ9NCgFZPMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IRTRWiz8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so77306841fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715648595; x=1716253395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5CdkRdgFHJBeaGlLOzrrq5zI+RRCPQz8DEEq+Gptqg=;
        b=IRTRWiz83i4UqiwhIBBUpEphAlUuqzIghxSw1Jwbxqnf8CL5yzSZeu7/vM2i57vxfq
         FW0A8uETIuIQKj6MC8AOjKfpR6RwimEDma83XyLFWgK441VLrRc56tVX/Kl96plgnJT4
         iIdV+xKC5t8X16n7GqPGyeFmP32RhNzGRnQpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715648595; x=1716253395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5CdkRdgFHJBeaGlLOzrrq5zI+RRCPQz8DEEq+Gptqg=;
        b=vmTGzaUpTy10yfZUK0V/xLbcz3H+Tv06VGekKcFYvFaAbUrJuJo7vy1xMzLApLleUf
         PWPEi9peUzajpGqufVfhEQFo6d6LsBPQseLzeJqBnS+yE+MNRYcPjcHsBR2lbdfbTAY0
         QsK1ejd3Uw3gFZT9Rhmx9C+Zyin6nm12QsDzf7wCB9iVASionHT3ThsacS87ggpNC62v
         v/A8cRuM95F+bOpsLU15NtjxxoFvSYeE7qMUtJc2ygg5zwzE5Imw5AYM575a9XeuXbmA
         eeaVBFW2LHB4Hs/D9CB54sznOJ6jr33ZKhLc8HOtpI183dlyc4w+PvH0k0dXq5oc7CXb
         NhrA==
X-Gm-Message-State: AOJu0YwghBCR+N3biS7tGlAEkbrlL6BWLjWxi3ifeAS5jbf3zdL5nJhS
	bGYVJwhlgYCX4MJTEoeYwii+9nxWYrj29VoJMSZsal1H0AC0amQ5ZqSAeW9YNXuMAi/WB4KhWAU
	APY+ktA==
X-Google-Smtp-Source: AGHT+IH4W5Cqlb0PxWbmwWIp70wiwaDrjlxCLPr77wxIiuK5amn/i+5CmqR23yZD5WBieeSV4C1JeQ==
X-Received: by 2002:a2e:719:0:b0:2e5:2f6b:263 with SMTP id 38308e7fff4ca-2e52f6b02c2mr76881451fa.50.1715648595066;
        Mon, 13 May 2024 18:03:15 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d162301csm16152731fa.128.2024.05.13.18.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 18:03:14 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f71e4970bso5922170e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:03:14 -0700 (PDT)
X-Received: by 2002:a19:7416:0:b0:51d:804a:232 with SMTP id
 2adb3069b0e04-5220fc6e614mr8505759e87.11.1715648593961; Mon, 13 May 2024
 18:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkG4cMe1TFI5w7sc@gmail.com>
In-Reply-To: <ZkG4cMe1TFI5w7sc@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 18:02:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf=jwo1HZjQN7UeFw7iYPtQ_i0ri7JNOci+7Rn5-pDcg@mail.gmail.com>
Message-ID: <CAHk-=wgf=jwo1HZjQN7UeFw7iYPtQ_i0ri7JNOci+7Rn5-pDcg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/boot changes for v6.10
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 23:51, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Re-introduce a bootloader quirk wrt. CR4 handling

I've pulled this, but shouldn't the compressed boot also just stop
setting the G flag that it didn't understand?

For example, arch/x86/kernel/head64.c seems to do this:

        pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;

but arch/x86/boot/compressed/ident_map_64.c does the somewhat suspect

        mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;

without masking off _PAGE_GLOBAL.

The hibernation code does

        pgprot_t pmd_text_prot = __pgprot(__PAGE_KERNEL_LARGE_EXEC);
        pgprot_val(pmd_text_prot) &= __default_kernel_pte_mask;

and again there are several situations where __default_kernel_pte_mask
does not have _PAGE_GLOBAL.

So again, the boot/compressed code seems a bit at an odds with other
code paths. The cr4 games seem to work around the fact that this code
is just buggy.

Hmm?

          Linus

