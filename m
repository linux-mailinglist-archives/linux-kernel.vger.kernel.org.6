Return-Path: <linux-kernel+bounces-556205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E4A5C269
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E054A3B2FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1331C3C1F;
	Tue, 11 Mar 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZW1xyzL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4681C1F2F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699230; cv=none; b=kSO7vxvLmoeHAlPyQkY1TsfstlPkaBHy+DWB2VE3Pfhn3I9dqxrdkZgYkSFoovZSE7qnq/vWwDfeHBbttdGMQiudFvULIVLC0boY2zjH7DpYaHLi5+J9dEdKM5qYsI+2UuKwwisiP7WhPUCio50JyckFX2J7xzcfV+oIfGtQigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699230; c=relaxed/simple;
	bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q23eUQ3yrsPu/8VdisZZJd5R+pyBgJxQB93kPDDPWsKqPYq6DAb1H0dMUq0/eiyVynSr6d5vjnxpO6zQ1lcXQCIlsYXTTpSsMbWsxkSYYKhNgfLCgK8M8heiFAAl9cjfKMgz4glYk/JYKEYm0Z2+R3HDW45R+C1uE00bBWfLTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZW1xyzL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741699227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
	b=SZW1xyzLE/24CnVwndDmIDNNcUpevMf+SMFFd+oka8bHHMBZ+UHQxk2MOtzCzG2wuW8vTu
	haKtXBOZB2BuqWzHmTPhsoP1p79ACDF+pSjmEc2k1Z50oYvWqLodiOHxWThXRwnq1wvm8k
	npcGCXCFzDwzBZUIZZcyIX+/k5QmZZo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-QY1tgQAvN7OPW18WAAxiNg-1; Tue, 11 Mar 2025 09:20:25 -0400
X-MC-Unique: QY1tgQAvN7OPW18WAAxiNg-1
X-Mimecast-MFC-AGG-ID: QY1tgQAvN7OPW18WAAxiNg_1741699225
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so654588966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699224; x=1742304024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT15IIAP1j3z5KXNjog/OnWaC0n2EV8wBw6ODsx5KwI=;
        b=qhW/VfO9SOFzq0883D3PXT9b0NAhtKYdLa9vJPKJCY077GCyj2JLU8dErIFhOZMMrD
         pK2cPYKK8hMXY3NnTwfB5gmX0wR4MhCBlaj0lKl5mwszLH7cLjIKiycoRZ7m4+nu8Bt4
         lK/a1hu/qkWCBqYpCynqiL7fpyjdrXRd5RjR9UsImatB6LKV10+SrydROOA3uteXD7Xi
         n9VL+JzOa1vXQXQY94zopT/JoPG4JL5vbrsrqtrQuKb0gJ9Yjyd/EjKv4MJp0gl6wClK
         TpLCznad8pIQnU2mR2G9AQEqWBtuKSIAIRbmtZrAjHzhSTli46k/APClWkyJbu1HGpcZ
         /wBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJJEkSCzltDsyugLZ8nkOd8NiBpz3IIrBzLDCanXVLuvYCTqLhGrM36ltMWjsbNIXT+ETk3PjYFCqwC3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlO5aTH2FV4w33QF85EDFFVw1T9zpvs6tPdtrc4vxztRFxKWGG
	0EClt0wqAbl3KLDN9jIgl+ioI6rmAWsRuYdFTay6kc9f080HuaS5DacJuZUFowv93Ut5BGRzuUB
	Qgb0xpRE94ByI+c3tG50t+RG3yB1TrMTx8o9nooyacBJf5WQoF8RTFAj2Y3Q6Ax4FjAIPUwWXuw
	8TQL9KqmnrzQehWAVuRgpaLADNWCuXvhaCaUXy
X-Gm-Gg: ASbGnctbXzVM6GN3ChWxpky660Qh9IPuDcLpwcyCGbI1Yy8Q/v9zL/c7hEfU/xEsZPK
	6y2qw6mBB+xmgxl92WI+Nk8RZiZbKuM5+bA6qkKUTtubyDOcMpNNs7sZTQvI1Zbum8LDa7IXQ
X-Received: by 2002:a17:906:dc8e:b0:abf:67de:2f1f with SMTP id a640c23a62f3a-ac252ba467fmr2029920766b.44.1741699224649;
        Tue, 11 Mar 2025 06:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYnj8F9Jf4SwA5xwmTqfm/NOh+ZyOvFJjWLkViuxqCpeNhUyvZDmEsh7nVvGxJdktqfaid7A4f0abzVZFRF0=
X-Received: by 2002:a17:906:dc8e:b0:abf:67de:2f1f with SMTP id
 a640c23a62f3a-ac252ba467fmr2029916166b.44.1741699224220; Tue, 11 Mar 2025
 06:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311114936.148012-1-tglozar@redhat.com> <20250311114936.148012-5-tglozar@redhat.com>
 <Z9A1oN_XdMguNgHy@uudg.org>
In-Reply-To: <Z9A1oN_XdMguNgHy@uudg.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 11 Mar 2025 14:20:13 +0100
X-Gm-Features: AQ5f1JreteHiyUMcyR3gnnzJJK9jqv2cIeQ3zXcakcHBGBF6xFg1-fV0um1ZFkQ
Message-ID: <CAP4=nvRCtRwXReMt8+vxjLVqtL_pR9OyKo0HS417+93QR84mUA@mail.gmail.com>
Subject: Re: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 11. 3. 2025 v 14:07 odes=C3=ADlatel Luis Claudio R. Goncalves
<lgoncalv@redhat.com> napsal:
>
> In the last phrase, s/is/are/. So that "If either... or... are unavailabl=
e".
>
> Luis
>

All references I found on this topic say the verb should be singular
(since both "BPF" and "the osnoise:timerlat_sample tracepoint" are
singular). Search for "either or subject verb agreement", e.g. [1].

[1] https://www.englishgrammar.org/subjectverb-agreement-2/

Tomas


