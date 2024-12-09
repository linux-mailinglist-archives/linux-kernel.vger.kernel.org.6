Return-Path: <linux-kernel+bounces-437844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4B9E9983
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D0928311E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C81B424D;
	Mon,  9 Dec 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vWxH0/h+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C41B4251
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756061; cv=none; b=fHqPm83LYt0MsgMo52juk0McMm58kI1bx5GQy+7j7lT2MciRv1h3CKkb0Hnm6Cu2ePCAMqd3rVbifvg2ob+rkFkKBN9fZrm3m/C5Flw1I6fnh3V7TUc6WcLWmKhFnCpHFbCmPGSIaRNsa/DZLK6/eRKJLSlCA/7M3RI9oFe0JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756061; c=relaxed/simple;
	bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmoOV05ydsBvRVJtSDZ6Z8FwFPCJNLmoq+ZTpVMy5DEkF6ea5J8PFMxgscn55apOevZJUeH53r+60kRleaWkr5tOgR8WvIKAxjSAMGbE3U6sPAYXAU3U1Ivd38NgXXuthuTxQWKW6VRwOs6aviRg7D6sjXRY7ihGkaSwPfKvZ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vWxH0/h+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so797251e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733756057; x=1734360857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=vWxH0/h+qrNQJBz4YdxyKiuKZte7A0qFI+1Js97zehJPYd4oKZoCWjMGIfJ6gB1PnF
         n/jDM81eeDWT6XzeGAIEWi2dOef+8L6VnveKxrtK2FB8SG9ATFLuAlquW3Et5+e54cEY
         1d6rAvEzT/EJrSAwrhAu6qgv0Ah5bDw4cwW0PQvqI/TTbdHUJ/vGOyzE2mjjXDUeUgp0
         L3TpyaZpz22PvnnnZHDgjTsAmgTulnKC7RygtmKnD0XJd/jMbg+abLJNridYhbONFOTZ
         qLFRUUp7xtIJBAjKrUTy2TIuPB1g5zj6HON2vKgZmQY73hENXpk9K4wdJHa24lSMFXMS
         lqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756057; x=1734360857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3uPqYvqbgHQKbRYysjnG8NJRJoMHAJpo1X5a/nsGbw=;
        b=Er18Cb6Qidcfalgiv46pCH5Rjg9q3jG42DsnRIvnLLiveKKv/NLGlZcfRHUeFVQFGR
         LI2rQPk9nv+1kNOcEF8vbZMl4ZgyJJT8zS8jxa9djj9s1BGT9q56gEGstrt6ye41wPF7
         b1SfYXQd14QUEE2bCx/NUH7N/XRvOhKjDmjpGLflj+QgFsNTMv8Wb8bHhWsRU9MTeKkA
         f+lXki5tKLz6ZfFnAwHkrwl2pLFi/B/WAXg+NPE/i7Dd7bo7E4Pf+8XNwpb9gTLGYOX2
         6LCTy0SgL9Ip/GieKZJ1uJrVun8HlrIZ8seMVkadtGSixAYjmbZ5ZAmboPd+4ko4Mmk9
         PAqA==
X-Forwarded-Encrypted: i=1; AJvYcCXxRSnLwWCfUQXzrlDNiZAo00ZFa4mOh41Cz8CgMXXQ5MhPZC7JW5jXd4gx0DOjoC/QobfNoNH5W05adPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJqFDBDKQPIXGx+s5PrAN3qH3Ku+9uG7kczix4odaho3uV77t
	J1sz9/s9sBtcR/g2o1elid6/4PULguUHXob96YrHagPivdEL2uFwzTcQOBuzXHbJJNgWv/rnnVs
	NbDcqYS0IvarKONbqfFlCQyP8wkQ4hV+t1vqg0Q==
X-Gm-Gg: ASbGncvjiXUV+lNHIMiWohbrWk6uqvxE0v8JlaPramHHXsCRlraHe+Fov3xHnlhyDLc
	xjF9vLSnKB2YAed3f0zbJ5IGK+gyWLNznZPlluGFcmKfmO54Y0hIbU6DPCqtyaRc=
X-Google-Smtp-Source: AGHT+IEznO0uqtPL1COzvxGwq+VZpn4uiLON1EYzg8NJIKAdwzxMATkws3UccavvSGGamvwnW6zKLVEwbVjxpooMKJo=
X-Received: by 2002:a05:6512:6d2:b0:53e:16eb:d845 with SMTP id
 2adb3069b0e04-53e2b7328d9mr4535052e87.18.1733756057474; Mon, 09 Dec 2024
 06:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209103455.9675-1-quic_janathot@quicinc.com> <20241209103455.9675-2-quic_janathot@quicinc.com>
In-Reply-To: <20241209103455.9675-2-quic_janathot@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Dec 2024 15:54:06 +0100
Message-ID: <CAMRc=MeA7vFiWFN6RExmiBFhrcRwfVdz07YdQJ=c0trTbeztNQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAxLzRdIHJlZ3VsYXRvcjrCt2R0LWJpbmRpbmdzOsK3cWNvbSxxYw==?=
	=?UTF-8?B?YTYzOTAtcG11OsK3ZG9jdW1lbnQgd2NuNjc1MC1wbXU=?=
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:35=E2=80=AFAM Janaki Ramaiah Thota
<quic_janathot@quicinc.com> wrote:
>
> Add description of the PMU node for the WCN6750B module.
>
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

