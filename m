Return-Path: <linux-kernel+bounces-448219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE259F3D16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED3216B81A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736F1D54F4;
	Mon, 16 Dec 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjChb5mU"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FF14A609
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386049; cv=none; b=WAcVptAjxHgwqy7Xi5QzocGAN0KTGUSYXbj7EkVymHCfK3dVqdxvHa3XrCipWFW0MIN/wQMo6uSBfcEB6gFgRDG1A/zHPU+5b61xwa4kB44eYWk6N9dqGz5l3Jd9+l4e9llFHJwNQJ14eS4i4CHU5qz7pgAR7jBpOkwza7tsaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386049; c=relaxed/simple;
	bh=0X/mAoqp/sXaxB7xCWI05qdv/rXkeMO6dZ+zaMAc/ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxVaU1f3rAo2IRNtgBgrcNne24le04np41IJgt/QspaRo72L3YOvp5dc9/50NH0WrHIXh7nvha14OwX872WdAm9MNztwJQLLQZljr6mNqmcY4cLa/0XlUkjoKeLpu6nmqXpGqJYGnXq3sGyibX9+5l+HfqCKPBKntksA4R4Rdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NjChb5mU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so41847871fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734386044; x=1734990844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X/mAoqp/sXaxB7xCWI05qdv/rXkeMO6dZ+zaMAc/ww=;
        b=NjChb5mURSU+dkI1z+hIFYy1qhxvgB3Sm6VIo66LumZ0DpiA+CYKcdvB42DDtbiri5
         tjP7B4Gb5UFjy9kp010S7c4bELozSFgQ3bLlNigjWsGqmUh0Ha+20ZWPD2IhG4SkfYwi
         h3UIXethqg38gKruAayGu6JYfYpJQze1rhBqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386044; x=1734990844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X/mAoqp/sXaxB7xCWI05qdv/rXkeMO6dZ+zaMAc/ww=;
        b=dcRKkH++RBzOaxYmmkm2pRYWfQygoaVEJAsV+x1XEbJ+3S/c2W+ECtwuTAXl4Vq+53
         mb23fa3RbAWndQw/JDNgYJx9r6YE3vvLCe6fiMEYKw8CVlVsfOwP704GBEb5Z44/z+fj
         026yC8xbPGcFUrnUtzvvS7PgM4JoSsuyR8lDs/xCG/4oLZwaz7vukGbxCgVnQpk5W9eO
         F0SYyCZlhAYJgIJB/Ign3PvX1qhFzmzOblklC3AVgktvC0/wEfyfacP32CUKOHbEGSlH
         pet8H2/jao9al/c7pLSucidkTR8zM54DZKMW5uLUBd+SCoVSr3dVqlhs5iHexUr4OikW
         aTJg==
X-Forwarded-Encrypted: i=1; AJvYcCW8z3VELki2A50SCW5+xdxVLn4kD0WlvTEcDlO3ffn7CBVlmtKQnE0AMyQGEgEdPFidwvDatmkmv0ixjKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPo/cF9I4EgGZJ/sHTUryzoePTr5H238/GpweklhBU39WIPS2P
	Bd2PSeN4x38s10iOv7m5mLZkCuHjDQf9mnL3XqD2rJK9rw01XPCV3EnHao2NWPkfl1CPeKD0rxT
	Q4Q==
X-Gm-Gg: ASbGncsz5it9XjQdGVd0Y+h3cGlc/9It1Wg7z7SqgPcU3m6gCGGml2JvbeyXD7JBkiQ
	KQYSxDIFJhH1GXiqcsp2zaS5B/fdhlxVyUh46yeSBoF7nXrz8k185ftluvOUVnR+fQ6womMcAyb
	AmIaqPN1UEIHa8AI0wuXidxoO+M5qISyfRxcIJnYy6NGoXnElqIB+ukYkWj7d5OIQE36si6yPbp
	dxk0okGvHyjd6o5uJTMqyh4CFqZzmZcdoIen8lJqEpz0enQF5YilIN1XwL2/3EBpoTYeLxFZqRA
	wfCwGh5kv8P02zedyy3SmRmM
X-Google-Smtp-Source: AGHT+IGAv5pdMzO6MvYw1zt2YRW3er/s4W9+kL6/yS/gFIk42+Fh4zQ9pNxwThLrLEpleyn1DMEvcg==
X-Received: by 2002:a2e:a581:0:b0:300:3de4:ff72 with SMTP id 38308e7fff4ca-302544cd51fmr55782021fa.27.1734386044550;
        Mon, 16 Dec 2024 13:54:04 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303440452f2sm10695161fa.38.2024.12.16.13.54.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 13:54:03 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30229d5b22fso49139151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:54:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBEStZ0b6YeabMpJrfBS+sOlLkniXQzwAgVoihyTBfOSn+1Vleh2tpdjyhzhXjSR1eTg+XE0ZzQyY6NLE=@vger.kernel.org
X-Received: by 2002:a2e:ab07:0:b0:302:3508:f4ab with SMTP id
 38308e7fff4ca-3025447d9dcmr52859421fa.21.1734386043147; Mon, 16 Dec 2024
 13:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid>
 <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq>
 <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
 <CAODwPW919K+XdxjUe3aPgxsv0CEWwx0P_Hxvf=VniLhk8eagkQ@mail.gmail.com> <2qx75syaojhnsqt256li6sinafml4gohohvld6uw3zhejrayuj@biiep5dvko7t>
In-Reply-To: <2qx75syaojhnsqt256li6sinafml4gohohvld6uw3zhejrayuj@biiep5dvko7t>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Dec 2024 13:53:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQhJcCNhSV7NJkdsuGjV2TVSvepdGisMU4reVUBURAzg@mail.gmail.com>
X-Gm-Features: AbW1kvafuAWb2tKHIUPH2ZldlV7L89d5SkwGUAoEp9RCWUT_FGgm1aB4MxqcSSg
Message-ID: <CAD=FV=WQhJcCNhSV7NJkdsuGjV2TVSvepdGisMU4reVUBURAzg@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: errata: Add QCOM_KRYO_5XX_GOLD to the spectre_bhb_k24_list
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Julius Werner <jwerner@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Roxana Bradescu <roxabee@google.com>, 
	bjorn.andersson@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 14, 2024 at 3:39=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, Dec 13, 2024 at 05:28:55PM -0800, Julius Werner wrote:
> > > Interesting. So the Gold/Prime are actually IDing themselves as
> > > straight Cortex A77. The Silver is IDing itself the same as
> > > KRYO_4XX_SILVER. ...so in that sense there's nothing to do here for
> > > those cores.
> >
> > Should we add some comments to cputype.h to record which other
> > products are matched under the same ID?
>
> I'd say, yes.

Sure. I'll send a v3 with this tomorrow.

-Doug

