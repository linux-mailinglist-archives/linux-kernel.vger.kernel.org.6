Return-Path: <linux-kernel+bounces-424997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA219DBC34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A1281FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D581C1F08;
	Thu, 28 Nov 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCpBp966"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5A1C1ACB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818966; cv=none; b=Vo4ylU5QZ5FfZnXqY1Xf6R0OlNLJQjyE4JyyoMDXMqTdk1VUdTmi11GN8aaWz5tmv2UPDtvTeBmsA+We1Rrg9nLaua3ecqCK81GVyw+9+iDC16muXD+mCF9TRZHAnx9a2Mt1nfVySRLD43A/+0IT4TzSEP90KvFjNkIBdxlfpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818966; c=relaxed/simple;
	bh=Ubvzn6fX/QlF741vPJbQrgZFw+uou+jS4l+WOSuJ+yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/HvLitneASmt2wkW2fEFz8NRyJveFsh/mzcCI3s6AgrlcqYBzghirxq/fI6OqfOzIuYEc259OfIltxGnSZqhUC/eAtQfOtRTC60M7ivKJjneqgf9GpNstrsQcskZI2lQnXOIulJ6tg7hvMGTti8Zo8+g5LgU0bdhj2hmz8ifio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCpBp966; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382442b7d9aso841241f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732818963; x=1733423763; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM9FRXdQ7XraFHzVrbpJT90ccKW9R2coxeV037cC2L8=;
        b=oCpBp966huI5bIP4qsopxctFxNAT1OOlfWX8ckukYqt1GngDVtk2KSithTW96jROWQ
         LOWP1lcrGffMh2HGIYW2OWq4lk7BEnUsJuCLvTLgf1L/6VhnU6JPu6F1+0p9toDn0V5h
         Ehvcd+S6Scm0RECmXuRZ4vEQjrxmaHwl3eyAoCkbq+B0LZnmC83N/UewelUTnGpYX3Ja
         G6N/RptS21VE2YJszR2iWNFGLvOKMiwONfi/NyTKKNsJoyOe/YDmnUtEJmqgzSVkl6wS
         70HDQTTza5znI9D77Xv9rDsHdqvNYgw4gT+vmKFP2NVaAoen36aJ+7DFyl/MDXn56HZE
         kmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732818963; x=1733423763;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM9FRXdQ7XraFHzVrbpJT90ccKW9R2coxeV037cC2L8=;
        b=dGlJgXJOIkmV15EQYNcywjECsrcd3d5ItUzp3ilVEju0XHPWBH2ve67Q5IvjXlA45+
         yNfSarg1R6qZB4LjaarIgfP7Kfx8mWKuBXIWoS5hzgM0BS8mnnpHGNrfC2On3f2DZQ9n
         EMzK54Wi5VSk/jEPd4qRZj4FFzcI+zxLhx7JVn5HrESvHHL4XhITKPC0r6yc3DWULSDD
         97bRDqJCpYPB9+73TRZA3z3DHLfOfhAA6Pd9ppEL16ch57Yp7pLYcLge+jD2xQ7796At
         7Wi2nQ+LMy1w58zrd7iB6FQ2dQNUFijjt6uszsy7aafSR4rcVoyD6UqpEK/ExmxWaQ9I
         uAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXtuaAfW4kL90GgB1ltNYluz/lir5Ey3AbTND+MoPrZkSVcWOB3TnIvhsrEE0wGulI+FAypDyTpa8zORmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlGexsXtz1sM06YU0JqsQG/iQ9JOLY6NGEyiuOangir6Smbid
	L5M3X29jWW1uJv88TvA9UEogsAYI3R5z/47+1oQiygdgTSPpS3E3d08unYwZww==
X-Gm-Gg: ASbGncseuLWgrfu7vKr6ICXeP1EX4jIHErpbA3anlB8YYqQtiA3bXSbN2aiLdDoOFJO
	eD33TKgdeLBVTFLD6zkHBtjs9veNeg4QZiQ2duowQtCxUlObtv/SGmtsIpf7hEmXqp0dIYnLcxp
	xbkl0+mlfVXdBq1Zk3Gd6sNlifwXgH/gAw9NLMdZRS5HkPUtQ1JD6Ew9BCe/LlEwnMonu848jXp
	13zNJH21q9kTdME0dO9odpo4HgH2vYGpxi4GRadAnB66+ORNUk=
X-Google-Smtp-Source: AGHT+IHwtzbrTZQq/kuMHiLgmkAZgYX0W7epxFqD6mJQJjrhi8rq1Sw2X7wHqwlDXUEtFBwWRKMKzQ==
X-Received: by 2002:a5d:6484:0:b0:382:455b:eec6 with SMTP id ffacd0b85a97d-385c6ec0cebmr6068685f8f.35.1732818962651;
        Thu, 28 Nov 2024 10:36:02 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:dce5:a12f:3f52:18d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm2328351f8f.7.2024.11.28.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 10:36:01 -0800 (PST)
Date: Thu, 28 Nov 2024 19:35:56 +0100
From: Marco Elver <elver@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nikola Grcevski <nikola.grcevski@grafana.com>,
	bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
Message-ID: <Z0i4DFnqRxTPOUfJ@elver.google.com>
References: <20241127140958.1828012-1-elver@google.com>
 <20241127140958.1828012-2-elver@google.com>
 <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL6yyRRUc1Xee4HOQ0QXEiqQ7M-xJ109w9aztYH4ZWHmA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Nov 28, 2024 at 10:22AM -0800, Alexei Starovoitov wrote:
[..]
> Moving bpf_base_func_proto() all the way to the top was incorrect,
> but here we can move it just above this bpf_token_capable() check
> and remove extra indent like:
> 
> func_proto = bpf_base_func_proto();
> if (func_proto)
>    return func_proto;
> if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
>    return NULL;
> switch (func_id) {
> case BPF_FUNC_probe_write_user:
> 
> that will align it with the style of bpf_base_func_proto().
> 
> pw-bot: cr

Ack, let me change that.

Below is preview of v4 for this bit.

@@ -1417,6 +1409,8 @@ late_initcall(bpf_key_sig_kfuncs_init);
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
 		return &bpf_map_lookup_elem_proto;
@@ -1458,9 +1452,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_event_read_proto;
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_write_user:
-		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
-		       NULL : bpf_get_probe_write_proto();
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -1539,7 +1530,22 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id, prog);
+		break;
+	}
+
+	func_proto = bpf_base_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
+		return NULL;
+
+	switch (func_id) {
+	case BPF_FUNC_probe_write_user:
+		return security_locked_down(LOCKDOWN_BPF_WRITE_USER) < 0 ?
+		       NULL : &bpf_probe_write_user_proto;
+	default:
+		return NULL;
 	}
 }
 

