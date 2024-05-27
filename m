Return-Path: <linux-kernel+bounces-190582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CEA8D0009
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF26283352
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB915E5A9;
	Mon, 27 May 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="aIalgtHa"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533C38FA6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813052; cv=none; b=FJyebNRVgGODLQedYyhgb0Ro5Ch6IttLyP9ITy8UEiYR/vOVPqAgN5gdcHWyUDh8xEKkQaYXviTT8KEspGycgHPu+93uMTnZ66t3Tf2tHcRuwKQN0fAQixHf7FCyE40KtVM121GbJO0amNcorIy/+DkFm40H1Qnwx0QEtBXlMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813052; c=relaxed/simple;
	bh=6+DvNF9RmDjZqkDGx57QY0y83XXuNrV7E1Kzbl2XyQ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gEyn80UJ3GTPG2piVQkWqJUoP9XD5N1j61zADWzwW58kik3k7wyZM2hnxQKxJlGIjVNwz7DAfoIVHkkUpQ4qtaKrHUeiP5ZFx+rAiN4yAT28uszv01d9xqeK8veNgPA6biirbwZHU8mu6vxHHqcdj9wWPvx4ZqMtC7ibzrGJcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=aIalgtHa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5cec2c2981so654396266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716813049; x=1717417849; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfzGbRD3sk8twjWqVfYmhO7ZpaFRIUQWKhYr1L1EPwE=;
        b=aIalgtHaJdleI/Fhf7+Mt8dZOfgMd7DJ4cc8oblSeemsMFOqX5aTcgxmAPI4EeLEk9
         GTHzVePq+WSqKTvpVigiqKs6znAv/Z9xq7/f+lyTmlLmaRwQx+AmB+rhaHtVewbn5TaA
         Kop6PsTQxbsx5qdP0l5YQRutW5EMmpLbTdd+yllMbZnqFaImOAJQXoSknd82TynFjVkE
         OExjAuNd2oTO7s/DyKCMVbIBw3p6wmkXi24Wnk68c+o7+s/XWZVUqmO9mUKXz4Sl+QKS
         AxZzhnkdGcwoIMNUQmDEhEioTa5R+zGBD363Gw7PlWIoDp35K59T64t/1ImdZv+IGVaA
         8pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716813049; x=1717417849;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfzGbRD3sk8twjWqVfYmhO7ZpaFRIUQWKhYr1L1EPwE=;
        b=QNFHdtYRKdObuHiqkhEcEH2v49tT+IEe+KVMM7cJFefZKvbOzClXQPvy+pNU4NB+vf
         6Iw2dt7qH1LyzGvmYt1Y17SQFYZY7BJrd0W0pSDPkMIcIGo8yRCh2iqGdPBDxa1i/j0d
         cb91H9NkBFtxqaeHqVpXl2BDFUh71xw+IydkG5iH7gmOnjRgSIKOxULyUr0DKiNIl0Mh
         XYJUol6KmfQNYtKMAzGlWk6y1ZE2dg5NeCq9YJnTjXPSzMNq6CWYGQIs8pXQ2UKNfD89
         CJxvXK2oP9/4A/yjgbNYPy2DTZqQNVTbofkUR+8dRy7VHbhQn0eodflzjis/e+9DlNGj
         rpbQ==
X-Gm-Message-State: AOJu0YyDhugdKO4dm+Tk+xGFq0g2jWN2wp6Noy1mGAHZLwFbJRxWggMo
	INRBwMTlE1o9PkxWm7yEtIQ2qEihsZ/JdD4gr23DM3EvLwQgXlPul/arI4dFdt8=
X-Google-Smtp-Source: AGHT+IFpUMr18cxOauY12oXYvM6RE8hLu/q+zupGiRCnd0dXkMbEPZiZwA/qkFVsXWVeyutQBdWRUQ==
X-Received: by 2002:a50:c907:0:b0:572:689f:6380 with SMTP id 4fb4d7f45d1cf-578519144e9mr7586305a12.3.1716813049163;
        Mon, 27 May 2024 05:30:49 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:cd9d:f244:3bcd:de57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57861b4ddefsm4475753a12.60.2024.05.27.05.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2024 05:30:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RESEND PATCH] w1: Add missing newline and fix typos in
 w1_bus_master comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <38eae3e5-cb91-436f-a422-0d03d4c8cc95@kernel.org>
Date: Mon, 27 May 2024 14:30:37 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <80088619-34B7-4815-8697-368EBB0CF48B@toblux.com>
References: <20240515101150.3289-2-thorsten.blum@toblux.com>
 <20240527092746.263038-2-thorsten.blum@toblux.com>
 <38eae3e5-cb91-436f-a422-0d03d4c8cc95@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 27. May 2024, at 13:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27/05/2024 11:27, Thorsten Blum wrote:
>> - Add missing newline before @return
>> - s/bytes/byte/
>> - s/handles/handle/
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.

Ok thanks - didn't know that either.

