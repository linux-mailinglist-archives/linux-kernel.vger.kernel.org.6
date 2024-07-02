Return-Path: <linux-kernel+bounces-238011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E97292421D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E781F25B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA31BBBC4;
	Tue,  2 Jul 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDhYFsJ+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB915B0F0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933373; cv=none; b=u0NVlGqw94+GD63daOa9/8dJUCjX8gytBaLfQhNrRFtPS9i1gbQctPErM/ARnN0B7VBsnStXnwwI/VcS7BcY83CVQxfl/mWPhVDVLQK7I3TJIShZ2CeH+bl/65NSwGLswcUjinQgWt8FB7+7z4k9COmxXGNjvEpQ41/1af/WOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933373; c=relaxed/simple;
	bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atwv6ccpHHvQ3/fv7+WV9Cbo4JVQ81LCwYVIApxVYwyl2Wi75J263EkVEHxlx1aIdMeRNyOpsgRc6KyWPPTxWi7Fv5OTa0C+1xS0rcwG9T8BA8JFbjX0+pl2MAXGbSKHZKtLhZK3aKWmpwNCrzen+LzJrrWOhEoVp6AqJK8E9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDhYFsJ+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e90679d5dso2308e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719933370; x=1720538170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
        b=ZDhYFsJ+jogtX4Ayq0BKYSLk+yp7ukS8R15IIZOMv0thsWe0AhTeMj60pk4ftidHWp
         5bQVl9nEBx6GswDwe760AJM3qiv/hQqoDWsO9/mtPi3VLiIq4NrzhFwtTQMDxtw0f0cC
         TTsdgd9d9ZLt2yMhXe18b17Ql2BOJPYJDK5ooJaOWb3khAVwqBLPPC9JmeyCgzizOMIQ
         l5qjvXWX/3+G5F2S8gVwRYUKXPFlAw1uqXiviDyrK2CrnGHIJCb2wJPXdMEPeHi0kjLD
         o9X4yNonrXxX1dH0qhO1xKLfOy8+TxQi8if94R+EjA40rumKOXviHTVvv5tY24/vLx5Q
         PjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933370; x=1720538170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
        b=kIYj99XFIeCdhvuzi0172MypSON1S+5dNI68jHKPjg6bDoNiYsWRzaTiVK+gkVrrAB
         7Cn4pT0rCPpti9VFbK07w3SXz5MVsiMhtf5uipG/tsV/jRa/SLc7MQogPGpJXaWHHto3
         Zf+mcjDVLR4AxCfLCtl9VYtMFN4FJxGPfQMPt4bh2PWf/tFQpC/e/6cbWtsiNOcsBPxw
         KLjsAwLTtSiwOcK9FXRwrhl7Z6gznmw5n/qAfDe2E/m+pETOqfoviXAYC7p1bHRBCWWi
         i/TtXOwpD/I5wwxKdtRMb9r9MoJpIz3I69QRDWNXWb9Fx4sBgpD6j/ugUq0bHS/A/hhm
         3A3w==
X-Forwarded-Encrypted: i=1; AJvYcCWLj/a6N/PxjBix9HFONFkloNg8yYGzdmcm7Xg1ngz/yIbDeglLNOwDzzSIVTco+BAcr1JPdiXm6ozDtTs603NWEE62wepZ5rDP2znN
X-Gm-Message-State: AOJu0YxlQlY1GRkw09y7wOGTJqkOvrtcDSqhSisrJMOXuNp2fXk1ql0O
	RiumpqTzJvMebouYPhvfzM91KFNidAgBXMyq0Mot8ufCdeLWghpIA1yqBpsveBGVqsBDODhq1o/
	BpX2Zb8OA3T8/9prp6OfH7/4GP73DtU9uwQfi
X-Google-Smtp-Source: AGHT+IFX7cHYnRfyVZKgBvOahQcReiRUsN8SfmAePb9EYJsizFIm/Tgu8OMWGap6ZV8kbrdWXuhSL9HzGY+dRqxmJLo=
X-Received: by 2002:ac2:5f7a:0:b0:52c:ea5c:fb8c with SMTP id
 2adb3069b0e04-52e93d5e565mr8637e87.2.1719933369561; Tue, 02 Jul 2024 08:16:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142406.465415-1-leone4fernando@gmail.com> <20240702142406.465415-3-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-3-leone4fernando@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jul 2024 17:15:55 +0200
Message-ID: <CANn89iKLWtyVP9-YU4a8cnE4Mj0zMNtzQkzkHgM0uqdQV-mcPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: dst_cache: add input_dst_cache API
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:26=E2=80=AFPM Leone Fernando <leone4fernando@gmail=
.com> wrote:
>
> The input_dst_cache allows fast lookup of frequently encountered dsts.
>
> In order to provide stable results, I implemented a simple linear
> hashtable with each bucket containing a constant amount of
> entries (DST_CACHE_INPUT_BUCKET_SIZE).
>
> Similarly to how the route hint is used, I defined the hashtable key to
> contain the daddr and the tos of the IP header.
>
> Lookup is performed in a straightforward manner: start at the bucket head
> corresponding the hashed key and search the following
> DST_CACHE_INPUT_BUCKET_SIZE entries of the array for a matching key.
>
> When inserting a new dst to the cache, if all the bucket entries are
> full, the oldest one is deleted to make room for the new dst.
>
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>

Hmm...

This patch adds 10MB of memory per netns on host with 512 cpus,
and adds netns creation and dismantle costs (45% on a host with 256 cpus)

It targets IPv4 only, which some of us no longer use.

Also, what is the behavior (loss of performance) of this cache under
flood, when 16 slots need to be looked up for each packet ?

