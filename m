Return-Path: <linux-kernel+bounces-246461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A15D92C1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABC61C22314
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417FC18562A;
	Tue,  9 Jul 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOcVpurC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23418561F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543986; cv=none; b=fHdtFAWA70K1FcckF2qD0evWP1AG4nr1blYl1DmuDIw0iJ5H350mkTT6ihWVlnUMGql7+ppFrz4kz1qjrxNV8sqqmCkJocQNv6hsX7oFcI8oBXpPkekP7WfVrwzT26HX8WkegWnbl69mMN89Co8oN3UbUdLEMIRf6oKWFAXZsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543986; c=relaxed/simple;
	bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph0+oO2pHrzwnsw8hmaHfVstCZkrUFsGo0cYic7S0o/k+BM6UFv3F/6+z9m5cvfB5zts6HwKKI+us7D5mqBRxMP/mSgixgUBkr/q6LKD1vJ56c/Mw+YndhgwB6O81Vc1RYctxpmq1zOz3G8YkE77s9v84ObHEyflWCywk09+7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOcVpurC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720543984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
	b=LOcVpurC1zrLanLTEHZK46AS1P3C8zPdH85I8CGFUBgBTh2RL5oBh88Chvf0fUoBGl1TeQ
	d7WY1WLQx1S+uYqEWBlw/w8NJIF45I0I9A+yAKHi7UcgXrdAIe+AgkwG2NlIvOcembXk+8
	7X3cQMKZVfaqedtZeoJ+MrEqEe4nsaE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-xlEVB0OQM064LTgOD-NA7w-1; Tue, 09 Jul 2024 12:53:02 -0400
X-MC-Unique: xlEVB0OQM064LTgOD-NA7w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1faf91cbe19so31629885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543981; x=1721148781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asVho6LyvrHD7BTUGcDSPeAn6LcjJzG6EHzs9v+6tKA=;
        b=RMKkkcnrNYFeRBb0e85qMdeh2nA2hymlcyL/SQ6o8tpblLkgmqZKhKqPiyNJBny9k1
         BYkeWxZTIWudJuxjBwzhN8Wx36lNxMq6HsL/7C5F3XjQpOZ6xf/e05O0ftNEiK9tC29L
         OQqJlKVXjCgGkaDpOEuLrhXzj7uViV/EojKvKBx8bwykEuweDgms0RCHwppfdV8g9LDr
         vpgvxKbZpAZ7T+X7XaMfsl7hn5EJ17QWzO3SDLEa4hIvMlyjZDhXG2BZBCAYe7ntTqkR
         Fp8gY6WmUJMEnRK7Xy21am8sctjgbU5ndjgAeRWESVEzhiinwlmCFQrxCvHnLwea/9eB
         B7+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8iZQ/SZJAXKadCmO+5mA0sxGBKIO1zgA1e1yD1psf7KxyBVKjAduuT7vxJDFO9qH2QOvS1S9v8vlOU/R+TH4b4aGZK9TlaWX3G5Wu
X-Gm-Message-State: AOJu0YzpIhx7rAPhvwXnXIikafwcuVsf8pJMBGtTO0wbhkrc/HHKxmVW
	RIVfrCAdruhdkrXmEqFI9IPVEoqxACCDQ56IgD2Jacn7QdgoThvEaPThDN+kLm0D6QUxlO+OpTk
	/BVRJ3KsECEuSmQhQ52fH50XVEOte15zeWdPSpuRK3O58smbiEN9U24nY9wKJdSGBnSwertSNv3
	glnh4i1RFdGyu+iY4QM7O0tslKmI5iF+107tAu
X-Received: by 2002:a17:903:186:b0:1fb:58e3:7195 with SMTP id d9443c01a7336-1fbb6cd186bmr25609485ad.11.1720543981614;
        Tue, 09 Jul 2024 09:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjlrmhgUpUlN7BW+PcaWbKq+/s4BVAK6LBnpJZZch5y3gF9SSouA8oyK/R0rkaxMPreuHVQIjkrp2zUEC5VX4=
X-Received: by 2002:a17:903:186:b0:1fb:58e3:7195 with SMTP id
 d9443c01a7336-1fbb6cd186bmr25609195ad.11.1720543981178; Tue, 09 Jul 2024
 09:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709163825.1210046-1-ast@fiberby.net>
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 9 Jul 2024 18:52:50 +0200
Message-ID: <CAKa-r6uyEz650x+TVZEsj3WiZ-OnMYycexEuiYf=HmgtiDx7iA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Tue, Jul 9, 2024 at 6:38=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <as=
t@fiberby.net> wrote:
>
> This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
> attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use the unused
> u32 flags field in FLOW_DISSECTOR_KEY_ENC_CONTROL, instead of adding
> a new flags field as FLOW_DISSECTOR_KEY_ENC_FLAGS.

for the series:

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


