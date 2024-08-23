Return-Path: <linux-kernel+bounces-298498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7B95C820
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE551C21462
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72D6F2F3;
	Fri, 23 Aug 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKpgDZLb"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C324F88C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401907; cv=none; b=a9XBxTg2Cj/Fde/USVNS9W0iDIxsVZU45FoIdeX0EutYJ7b71OsqrN33ffWPadMdS6GKqZIjhMGPl0Wl/th/+IGPGAgu4QPFcRmt5zn4JQVMEKcbSibzhp2oWgTxNlspIIgxr83pl4WktFs6n5THoABafkpuf/sWY/BWuDiteMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401907; c=relaxed/simple;
	bh=SPa15IxMtD1+oEt0qhbtGb1r7/rMPjjAGbG/DvezoRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx9BcYvtYJmsnVfhcuCI5U+8+zFXxMWbO6fU8Ecw8DJ5bJ9eCcPZLqjV7CTxpOs2SO8zUBCYMr1q2mTt7I8Aw9KMIsWgWj8uJ6MV0TFyWOg2tPRF7mJoBnU9R7fgajuwaZN+CcKENriqt6oyJBOfp010p1+7R8lZKycCsgDD/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKpgDZLb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b4412fac76so16028617b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724401905; x=1725006705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ7ulpTWG+6HgKylvJsyXasgt19eHQQJ+2F5s9QNO4Y=;
        b=tKpgDZLbqPU5H29JibzR6hJIQGZR6epYCaRhz2uglTAGScp1vmWDinXpPxJBbrN4cO
         mu+h0af5UtIrdV72YgMBWew5mDy8tdzld6+B9gu7fBHqll7Bn3TZ/8sWom598pdALXJj
         +h5+CmEG1VKy7i6gJHcCbuZzYeSxkMmpILgOga1TceYesf7+fAqRGF2KIuYUTN1fzXGz
         pEOHZrb0O54ge5PBszJbdUGAPVyAUD41eyyGp1NbgXg3w6p9BppSDf/oqkDw1h9X4JSt
         KdpMScOSneYXm8d9IrPXH1IePDlUjzCYPQbT0+Z+8j0cIHpUvIYFtIAfG6c7LFtzjYpA
         pt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724401905; x=1725006705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ7ulpTWG+6HgKylvJsyXasgt19eHQQJ+2F5s9QNO4Y=;
        b=pnE8nZIdPg12qabAFvpbWAfzB5HsFD3D/oPzy+Pk1xALJYc3neLgqGJODvqr87YVp7
         PqXa9pYg5BSqP4lfhdHaQQqML7w6ZfEGysM8gwfmY2a+2NNuLqicj3Gi7+KN+pq48o1g
         m7glndPgOo6x9K83rBeNwagtmN1hwNbHnAYIT+IQoeSGQBnvB+aujM1Jw5qDWyvtvXiO
         XTa1dMgsIATcZ+xRIOqaE0mCW7E0GvAcUp3VKEr2vQNzBHzcGqAdXSCvWELbgxkt1Zvj
         UPz2TLylekHNZJV7gsMuoAmaLn27tIe/9Nd7PIP/v12w27mNc8Xd96iAjT2sI32MPqVD
         m5sw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAFB9cq4Dz/Qb5DLE3VsfQIdlI1ab7UPSzzjPS6UcRECmVKWZcgcaN6BQ4cMpWENhzelUQuO3stYBeKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLfrJb2JCx4lDEt7fnNNz7h+FlMyMf4CbKmkKKp0aVp8fqeaW
	Ht3tlXVcYqn7azzrO/jLSLdIMPOblc9tVfQTLRmdpMHO8A+4L0FNII+C2lOWbyMRloXTwQNIHSj
	fkNEihoO17fiUwS2ZtZIN6bzxh7Vo1flAxkPAIw==
X-Google-Smtp-Source: AGHT+IGdbZDfcNoEUAB0bb/rCb0T98GoH36MoE5i8HUCFy4dJ6s2GKkd5DSz+YMp+FRyq0Ql++zMNaic+QIGlp7hpk4=
X-Received: by 2002:a05:690c:fca:b0:6b3:a6ff:7688 with SMTP id
 00721157ae682-6c6243209e9mr16621977b3.3.1724401905207; Fri, 23 Aug 2024
 01:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=Mcrrhagqykg6eXXkVJ2dYAm5ViLtwL=VKTn8i72UY12Zg@mail.gmail.com>
 <20240822211336.GA349622@bhelgaas> <20240823083004.rzylgm66yaw3rlyi@thinkpad>
In-Reply-To: <20240823083004.rzylgm66yaw3rlyi@thinkpad>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 23 Aug 2024 10:31:34 +0200
Message-ID: <CACMJSeuHkbUYSSE_7=HE5L2_j4LaR_jA2XSDgg_6=WFd_GdE2g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent pcie hierarchy
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, andersson@kernel.org, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 10:30, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> > > >
> > > > Right now the commit log doesn't tell me enough to justify a
> > > > post-merge window change.
> > >
> > > Please, apply this patch independently. FYI I have a WiP branch[1]
> > > with a v3 of the fixes series rebased on top of this one. Manivannan
> > > and I are working on fixing one last remaining issue and I'll resend
> > > it. This should go into v6.11.
> >
> > OK.  I just need to be able to justify *why* we need it in v6.11, so I
> > can apply it as soon as somebody supplies that kind of text for the
> > commit log.  I.e., what is broken without this change?  What bad
> > things happen if we defer it to v6.12?
> >
>
> I'm not sure if this is a 6.11 material as this patch is not fixing any crash or
> potential breakage in 6.11. This patch changes the hierarchy in such a way that
> the suspend/resume could work fine once added in the pwrctl drivers.
>
> At the same time, I'd like to get it merged separately for 6.12 instead of
> bundling it in this same series.
>

Ok, I'll find a way to rework my patches so that this one's not needed.

Bart

