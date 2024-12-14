Return-Path: <linux-kernel+bounces-445819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5A9F1BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15104188A959
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934F10A1E;
	Sat, 14 Dec 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QueuqPp6"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F3D528
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139749; cv=none; b=DsR1AYfeLPoJm+NhCoB1vwxAst+SyS1stDOmBjLwqYfAtIg7pUca+a/T1QCTaByBY7KfaSs2CM1w8p/TQTVBkjA6CJdQ7f+yumfhycP2aiITqwIazxeKv9gaDEkFtEU38rKezY8VGoAakQzGoaYHgwan60B3W7O0OQwDWKiHDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139749; c=relaxed/simple;
	bh=FbACf+zYDKXAWssDymW0DKWC7LQPGZm8j9ATdknhB08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jktpB/Jnjw05StII8l0jrMY5iBIbTBH4xJZ6+0NtxQaOGHgXjkB4gusAnlluMhPn3sn5FCmlVr0v76EHBUAzxWlFDsrYieKzfon5fSHbMQC0exOt4LypjZhXUHKzCccvGjkFFuLptpevGzPIcmgzJy2Sp9UuBpk6fziZKOS0COg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QueuqPp6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4679b5c66d0so50881cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734139747; x=1734744547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbACf+zYDKXAWssDymW0DKWC7LQPGZm8j9ATdknhB08=;
        b=QueuqPp68OWaZl6pXQexQdOxkH/CYd7sevN+Ed/04hbPHRcPPkwacF40NX65bq0u8S
         FgFmE0BeLWjF3JITg8d8VWs7mI0S1HhUHTXsAFdAUH3otsDl9d8ion64jueyXshF3nbZ
         LHsEbOZNaicG8YabB/x7Who7oX7DV0bNzfg7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734139747; x=1734744547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbACf+zYDKXAWssDymW0DKWC7LQPGZm8j9ATdknhB08=;
        b=t+S9/oAl+pccnH8zefsPngWU4DOIFWirkA7lTP2R0YJouanZ4CzaadnpPrsDNcz+tz
         92puzzRJwtCJCzqyy1O8UyUY201dwLJrZAjHQBteFM6mFXqoLLUq0rt8w8UP41t65hYV
         GArJGNVF7ZhFmz3vKTjQOMV2BBNNZd5KSQJ8zZINsudvjZ9lP1xKKbKDJtWZPO2MqoBH
         VCWKB7VdaMinhS6YkAfuCOp2dNCpy0ozSvvtydxsP0Mde/XCYtcYWnFozbxZlCgM5ST6
         X2ii1d1QRz1R7hXgljemtxwzUBrVBhi0CC9Z3sqjT8FdLNDhnAkz9zjOKn2IdgHzVj5r
         RTHg==
X-Forwarded-Encrypted: i=1; AJvYcCVcT8vDfr7TrleMSK9znVGPnOwdWYA1D2zYc8wSM0xryDdtkDGQsTTdJzZx5LWBADsANY9HM5ghoPdEMw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FhxvPJtc/fLWSO6Z6M5CvlB0YQfyh42WcsH8T1bUkr70mJkP
	eECkVq9B3I0BUqyrW0Z8OWz4+9+n7GJgOCCznwDyvLWNTmbu4tdLTZ9EptNJ8JwE9hKy3xUAziT
	pQhnfbxkzY1YwAA3Nlkhj7O/eu7AXTcA1Nwxj
X-Gm-Gg: ASbGnctvGRFlnj/75JZwOrOl8Zidi9iVgibvuzW8wj7tc1jmajyo3YZFl+EDQ0X67GF
	PU29wiXc4ls/ah0RXSW3HhU7WyTOf0cRvaCk=
X-Google-Smtp-Source: AGHT+IHNtwf8QADinV12qA0ZzZiycG5IyBHw5q4jrC1tLoJV04+MI6FXaBeKEVoVuATlTKwSTdw0HE6Zeb5uzLpINtk=
X-Received: by 2002:a05:622a:1882:b0:466:8c23:823a with SMTP id
 d75a77b69052e-467b4a2978dmr640821cf.17.1734139746638; Fri, 13 Dec 2024
 17:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209174430.2904353-1-dianders@chromium.org>
 <20241209094310.5.I41e227ed809ea607114027209b57d02dc0e98384@changeid>
 <l5rqbbxn6hktlcxooolkvi5n3arkht6zzhrvdjf6kis322nsup@5hsrak4cgteq> <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
In-Reply-To: <CAD=FV=WQf+ig21u316WvQh0DoKsdKAmZgqPn5LB-myDXsJtXig@mail.gmail.com>
From: Julius Werner <jwerner@chromium.org>
Date: Fri, 13 Dec 2024 17:28:55 -0800
Message-ID: <CAODwPW919K+XdxjUe3aPgxsv0CEWwx0P_Hxvf=VniLhk8eagkQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: errata: Add QCOM_KRYO_5XX_GOLD to the spectre_bhb_k24_list
To: Doug Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Julius Werner <jwerner@chromium.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Roxana Bradescu <roxabee@google.com>, bjorn.andersson@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Trilok Soni <quic_tsoni@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Interesting. So the Gold/Prime are actually IDing themselves as
> straight Cortex A77. The Silver is IDing itself the same as
> KRYO_4XX_SILVER. ...so in that sense there's nothing to do here for
> those cores.

Should we add some comments to cputype.h to record which other
products are matched under the same ID?

