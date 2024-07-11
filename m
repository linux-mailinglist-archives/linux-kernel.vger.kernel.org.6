Return-Path: <linux-kernel+bounces-249490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53C92EC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A2C285319
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07D516CD18;
	Thu, 11 Jul 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3v87nGQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCA16B392
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714288; cv=none; b=dgW6S1OQzyS6BkNaA4chkH95mNUwSWul9kh5VucnWTUYqAuI/uHjE2ZKD998yjHb6AhC/OEfSzMaPCzWUQSTZUC7x8/Tzu0E+vESjm6Q6wrQktnA9CLY5RoDaQ1RB1C+MEU5Ar6cilzjwT1KnAZsJ0J1WbXHKG8+watdASOfJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714288; c=relaxed/simple;
	bh=v/Q/FkYQWlP5mhjRIjT1FY0WOityzEUvvrsfXcoTSMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke8SxGrsqzJ4xqbk/D9F9nBMSiaAZrPvd+gcBh/ubd+A++zT0mF9aVWmrDkzxAFAGqJJt91oGudSkDcxI+blzd+TTeUN1k/8XX7KtJ6lPCL+0MW8oUjWUaYtVB68pshI+11p0gwU5uNO0Djoa22XsWU8Ro8ubvaobb7lQxrtVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3v87nGQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so14774a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720714285; x=1721319085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s55DGZEOMg9QZyntspE5hZ/WZzvStwyhAiZPOpnNBOw=;
        b=y3v87nGQ8GNXpOfw3nPsFkObYSPF3YmtCfdX3ng07LOkc63BtvoZK6RI9l3jKTjoW1
         LjnR2QPCODB6tVUsLzV2XsvsTNbbo03XnNf2L0MjWWQGcnLE6s75J4cNn5bt1sYVeuQ4
         CJ3csHfajMLkqHjLtg0Ncy3+nCeMQ7Ty+UlhPE5sHyNtIqEvm971xaLiaCjd19r3YolY
         Zij2fIu5soRQWUC3UZYkPL4ZOkTEZzThjfGIFGepmywfQJ53ONKajc8UMiEoYr+XH/sA
         MPwnLfyQY3MU1s2MdEmrLCKrcas9Rgk9zvJu6mERC0+SS4O/RwocUpakd6KQt7WsK5KH
         AZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714285; x=1721319085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s55DGZEOMg9QZyntspE5hZ/WZzvStwyhAiZPOpnNBOw=;
        b=U8eWGRIL1AX7vMJn0LCHpUvzQx1AUbrPTnOnV0lA3KcsnvcflkebVoDm17BdHBFQeL
         ENghBQkLxLMI4wRJBtf/sEwga4gs7lym9LRJfuRoDn7gMu99stFf0A7nnbEFTsZDI72+
         ST9Zb+lrmeopCj/JPZAVe4BUrgJRLTddMolSRgpmFVgZCNAM3PYZE8Hoaik1cL4ReLRt
         EgT5r65rMo0ZA/ql7xfZeJZvrjarhF14TmzgnLhvuivR9ycfoKPW+Q+fO5lfBBWnBEPU
         MqpYLLE78nvrG9LW1VS9BIM6ackVVaYhG6DLj1TAX5Pbww35fzCNUyuFDWNPX6uBZtet
         mTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg5Fw6zsYSvK7lcp2cL+Y1PHbLee7xH0yQyAPYRQFpF+i0TAw7jJnE+2E10ZIPGTw/nqzLJ+48jRX5zwFq09/xW9PJXBtPv0Bgj83/
X-Gm-Message-State: AOJu0YxKh5ajLip74stX4v+0gDJ/9Kl3khHhUYsKsJkv5Cmc3GCLaNxm
	qQuJSI6yhWmbl7T1YvjIe5mxFVM6J/r0bNwbW1wSU9DdIgQaCuIkakBUeZ5X1qc4RuNzbfUVVVl
	CqR6rdY1BWpgQJnVaYyrjABHbKcUAsR7D05+U
X-Google-Smtp-Source: AGHT+IFRIy72DxyOnaKptYGPfmSI7TYhaeEIrTEN9HpfourjbZj/0m6vpze7o2/iiPAowVfOKX+Zg9a5/Y2TvKMPASg=
X-Received: by 2002:a50:aa8d:0:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5984e32241fmr231681a12.1.1720714284727; Thu, 11 Jul 2024
 09:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 10:11:11 -0600
Message-ID: <CAMkAt6pYAKzEVkKV1iriQei3opD9j3M4bM3-0yB4sX1wss+jsQ@mail.gmail.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
> +{
> +       struct userspace_mem_region *region;
> +       int ctr, ret;
>
> +       hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> +               ret = encrypt_region(vm, region, 0);
> +               if (ret)
> +                       return ret;
> +       }
>         if (policy & SEV_POLICY_ES)
>                 vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);

Adding the sev-es policy bit for negative testing is a bit confusing,
but I guess it works. For negative testing should we be more explicit?
Ditto for other usages of `policy` simply to toggle sev-es features.

