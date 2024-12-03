Return-Path: <linux-kernel+bounces-429929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F229E2CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA10B32AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256731FA82C;
	Tue,  3 Dec 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSahc4ZK"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6B1F9407
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246661; cv=none; b=XYgPRt3iWLsJI267SyFtRSovuhsOCvENsASeI6oGa5nASlvU6csa9KceA2Iu7YPxYvJTV6DYPahmf2mVyq2LxyPirszhF0iX2c5AgvGdxnEu+BM1Y+UDAqbTvB9z8ugnSYB3g6g+7+i4RkUycclEBaSYOqLCbH5F75CiCCdBgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246661; c=relaxed/simple;
	bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJIgGnxZ//jJHjXJgIDg3CLI9EJ1icC8DYYNIX2/qRUSO5VveE7c4BJE6Xkd8lvBIWypGMvVCQg958gF4ac44wQmyA3k+akxp+R2NVeuL0oG4J8VychuabsKfS3tAQzqsTSAJGe01kCa0hwgkYxJsaCPXAewLrzem5wiMhDJebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSahc4ZK; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5152a86a097so1188799e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246659; x=1733851459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
        b=zSahc4ZKmWqVMYt4+SUPdW82xrAOdrsaiVA07OWXcieX9HbYS4pJQdfQ3lLuVjqErp
         8IJFDNRnfo8zcIeASMsDzj/n8GVa/lCSkWDIsiynqXZcU78GjRpTTFVy+SFiR+iKbjtH
         XfGtD0wkMlVM1PELvkXGpnUXarepCXyIYL/cg25VwKjkv28ALx4hqWO2wp67k+1M1Hx/
         gHnq5zTUr0ucIt0ajYBUxstdb/zXg+sF0bn1Zlzmo7Jr1PIbZjW75S1dbiEPL9FLN+d3
         +jRPc9NPOrUQ81JIoOGcp2NH9GuKG4BWAEWL+NXnjCjTMGmT75Aw5CHC8M/qhoqom5gq
         18ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246659; x=1733851459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHhOCluAWImlIGsIXn1ThfxKnnC7/xPE7QIUhoZLgQk=;
        b=c4Hl4CPqqFA0E6AzMuRVNI0uRemBM3H/TymWSkV0TBEKLvRNYccUt3S5/maUvt2MoB
         6FlwIPNdXcan+Z8OR89hzJHbyIuU2xIxQ3bZW46SKz8AQ9B09WFQU6XVv/ku5M+mWMwi
         vpsxmMS0QQlz2H8iKubRU5y07zZjAuEBY8UYH6shTv50+/cAS5IWlFpPzCDDrim7QNcX
         xL9jskXGVFqDaQdxH01yQAuohY2F7sO7oO29F5CKC6METUr51iVHR9HlB47dnRCkscCj
         8LDzOM6BeuhhksCAifewkq7Pzoai7X3NrVKTw1Et+LCbndOxMvV6PUoXAMdvq8KHofLF
         tOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVznhDdNeJMBfY/0uZid8XWsR+pMfaMQhh9xt/l3V2hUHCMU8djCNe+tKXDm3BJz3OqP+cwfxwiKK6OZSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKVg5Z8zV8nBT6qg7fZV2IFxzP/BXvRP8BllHsRcNU28dcgyH
	YHipbqcEYo35filPVCHJMn8C41AsnFZjXvjW5DDJ6dgEMAR9Ifb9MWTgIg3+q8Vf0P/AvcTC+tB
	VP47FoaAh4j/ACZAZSyX8SfV5V60GTmR3lPZC
X-Gm-Gg: ASbGncvG/gHpQCn3NXg3JjsxX8KCwPMm8mkyra+B+NSHLPIL6qotKfKBXf84fNcJ56/
	0Q0A3e+I2Yx6EkYtIO7IIxG3geIqvpoT5
X-Google-Smtp-Source: AGHT+IHYXYoqonmkZPTMlbc42ImybA+UEjnRdgYrQbkXonBRpfG03UbuA+XwLsr71xscM4WaS2Sc80eQ5GXkKX6c0HE=
X-Received: by 2002:a05:6122:6593:b0:515:3bfb:d422 with SMTP id
 71dfb90a1353d-515bf5c0701mr4617322e0c.12.1733246658855; Tue, 03 Dec 2024
 09:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202204530.1143448-1-leogrande@google.com> <Z05NhvyagBbHs8Gq@mini-arch>
In-Reply-To: <Z05NhvyagBbHs8Gq@mini-arch>
From: Marco Leogrande <leogrande@google.com>
Date: Tue, 3 Dec 2024 09:23:51 -0800
Message-ID: <CAD1qLz0UwaFsk3ZnQ9e5RG1XvJ2i=7FJhtf_9AB6KVZ1fbEh3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/testing/selftests/bpf/test_tc_tunnel.sh:
 Fix wait for server bind
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>, willemb@google.com, zhuyifei@google.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:15=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
> Do you see this failing in your CI or in the BPF CI?

I see this failing in our internal CI, in around 1% to 2% of the CI runs.

> It seems ok
> to add wait_for_port here, but the likelihood of the issue seems
> minuscule. There is a bunch of ip/tc/etc calls between this
> server_listen and the next client_connect (and I'd be surprised to hear
> that netcat is still not listening by the time we reach next
> client_connect).

I'm surprised as well, and I've not found a good correlation with the
root cause of the delayed server start, besides generic "slowness".

You also make a good point - by calling wait_for_port this early we
"waste" the opportunity to run the other ip commands in parallel in
the meantime.
I had considered moving this wait down, just before the next
client_connect, but I concluded it might be less readable since it
would be so distant from the server_listen it pairs with. But I can
make that change if it seems better.

