Return-Path: <linux-kernel+bounces-391005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48E9B8117
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4377283265
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EEC1C2333;
	Thu, 31 Oct 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkWMWtWD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F519E7F9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395231; cv=none; b=ktZuOAkDnI09UhMbt7QL8/wN5KlcD9o3TnQHDZSv1IbqL3UcqZ0vhzh6rQjZaaa682/9Wgola/MXgUGWsd7fyfTnq24ryjqxHrJ+SiaK0q5fnDAkLQl+WUbntuaQI2tqqFX6Z2yYYMV0zGJZs/ap3HcTHYAxNWeGUcJ3iHhiPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395231; c=relaxed/simple;
	bh=Qpfn1aqERxQIIO2RpljK3QlpdUDGs/PQ+KjnHTvZPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skp2efpkBMQbiWytziaaAisZPafvrbXDzzEio9yaw4NG5K3ECIbTBjQ/hHZE53QrOhnd1ZX4oHKyMPrNXXJrTdntZ/Jl9x4lwhuvD2sgk48jSR7a78LnuiOTI6u3CdPejQfCk0zzTWflGO+3xd5T++q3WxRYKU1BnXqIYAWsY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkWMWtWD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e681ba70so1561e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730395228; x=1731000028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=lkWMWtWD46ADG8jSwjfHnEmlVrrgNDA0o6MP2JOK85moVKiCMLk9+DwYBoc5vUypqM
         M5mpsiALO/I8YrL3Pe4+U5FpM9tbBlqBaI5TLpn4aNhv6COACGcZFgivkSAnVUX6Zb1m
         lDDuOYWaBYi/WqzKWF/s4CrD0SXEjsRg3VPB0NBPlEqqJ/2lasFxT70La5l7RtY8K+j7
         /uN+NyE/s4IW5Ewr2VU2PAE4z3f+SJ+iM0nbHpSpECHt+K7R8Yq01Uzdu5lB6Bg8UpQb
         VRAz634vKYXRMHUS7ePbhf4HhMsDVj1hlCa3E47zpGflO8zVkqkCqORQxN/tEvc6xVk/
         Uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395228; x=1731000028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg+rF3bbkwD/l4VpYrtWhBYduAyO2UrjlFMGIgBxxz8=;
        b=oYY5je8RxAXfc6/MJaZsmqB0tseSe3X4dupXnOEToUOZ8p1Pq/i+nRqtr3DcikDoLN
         XaAF17AIRy9Lnsj24z2H8y9tl525KjBEj/x1MsdHPZPqVGB5SVLnQ+0L4oZ5XHiEFKe6
         hKclv/n4xx2UHFQvBxDfA8S7hrk8KE6jIoveP9W5VfE+aDDgv7RlbDosm0Pp90twIzoN
         eGJSMmzj26Rxicnz0atNsqtfMRuJ5XvldtyPUlXjJmbbPjmh56+yKdLsyU0MOJq6N6pv
         Ti2YJdld0PSb05u/R6lM4S28kxePfu43/kjMiuF26Itg1HhpvsVxArth2lkFywC4EwsD
         aR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVM2HeronGTk1+gS03imCR422Le8R0mzHgySDcvn5EyCunJJP8zshiG++rg7qoquZH2S2vBDb1MHxlLMK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6GstCIBQ+ZkjUd1IYjAqV2Xw9uqzsC5H1BURfNjAVxfrCQc5
	M6kF8qLiFolcOtx2M3rP+86uAqj4/tuzQKMSvceTjhOppsr1jAqDveQYeS+ZGTgy7EUfBF9iwWY
	yzIK5ijB7NzICAMoFZ4E0VTLvGZEIQtygMH24
X-Gm-Gg: ASbGncuIICcCcgc58jITmyooCRYGaysXPByMDh14SdiM3rjvikPImi+ny+Kku1b5Wph
	HatHSBpRT2/kondZMREIwuw7WrjyGCofBdO0aNaEQdllz4QGxqcHr6pdyUcWkMQ==
X-Google-Smtp-Source: AGHT+IEv90dd5q1CIH9Mt3/RPC+ncg8zHsWLi93i93FxiGZUohh8fnGc3oCrDv0I2EcVmSgpEDXcHBPyCl2iNQcs/7c=
X-Received: by 2002:a05:6512:4024:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53c7bb8e9f5mr285304e87.7.1730395227548; Thu, 31 Oct 2024
 10:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch> <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
 <ZyJSpBrhz7UJ0r7c@mini-arch> <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
In-Reply-To: <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Oct 2024 10:20:14 -0700
Message-ID: <CAHS8izOUx=_HqS8foFoyv7H2d7zz6+jchG2r7w+LL9fq8CJvLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:45=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
...
>
> Sorry, 2 issues testing this series:
>
...
>
> 2. Validation is now broken:
>

Validation is re-fixed with this diff:

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 692c189bb5cc..494ae66d8abf 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -568,8 +568,7 @@ int do_server(struct memory_buffer *mem)

                        if (do_validation)
                                validate_buffer(
-                                       ((unsigned char *)tmp_mem) +
-                                               dmabuf_cmsg->frag_offset,
+                                       ((unsigned char *)tmp_mem),
                                        dmabuf_cmsg->frag_size);
                        else
                                print_nonzero_bytes(tmp_mem,
dmabuf_cmsg->frag_size);

Since memcpy_from_device copies to the beginning of tmp_mem, then the
beginning tmp_mem should be passed to the validation.

--=20
Thanks,
Mina

