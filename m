Return-Path: <linux-kernel+bounces-353458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA7992E24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C791C22F50
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762101D4175;
	Mon,  7 Oct 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdyExYMw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEB1D4159
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309638; cv=none; b=aQFEATGWMxv6vqnLNgaFJGa3uvYBxzz3jSiN57jqUm8JMfaeIcHRmN859U4Q7MjfsvxczhhQcF3Q7f7BvNNtfc0lkK/jB/NARRJKLUc1KoWOiyTpZr/peZJONRRRNgeV9LrJzaljXlEEeCoB/UTECT+JUiGlwExW31EUaKghyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309638; c=relaxed/simple;
	bh=tzGpZ1B7fLhxjfs5UNJtIfBOrNHIIXSsKYxOPsRE4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL4DNsF6eaDTLL80vPPLfoHfffUX+wbHBst4KY0Bh2VMIVIpcX6LpyxRF6PDfyUDeQSWkBLquPJU8p2iDZXKGcZuH0hZ0ec2gHnf2F0RMwSUc0ZRGaBjmwUhVsDu5ZIAQQcmv5i9Mm+UJ9BG476erVdn/kPc3BB5VTwv8Hylb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UdyExYMw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so5364314e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309635; x=1728914435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy0Gz3EdQGICzEnD8uO0/8WhRra84BxD7rRmoP1WUZg=;
        b=UdyExYMweQhf+E6SJEMdDCQkDx0pW2r/swhKNEMNlXEXVIAbclZeI0i+vQ57kDBROk
         fvFz+ysbn/vtLfJSbK4x6PcSAKRzsuF03iIieQEC0bMdJ4rJNTeznJv7euIdJ0hFsZop
         yZrZmEt2wZiFQXlr3VT8bIJF7Xyw4SFE67AaX4zUMQcaktB2UCprGs9U7bvoqaq0iITM
         Emmk4d09oVXso7VSFlXBp6mP3TzvfwUERh3hm1gPN6z0t9VIYEld989NgqKtIRobp1yZ
         FGGFZVwKkTqRxFpq0dn+uDjDS7r3fM26QXkbGVD1Y0n75w472KhmNkfu17jI+BPImFp/
         u+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309635; x=1728914435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0Gz3EdQGICzEnD8uO0/8WhRra84BxD7rRmoP1WUZg=;
        b=thrBa6K5SFrlWR9mPPlE69XqVd3RPR76unIJKoNG322h4p5wlec6e+E2qFqeGiDCeP
         Ko7/nxMfptA+9LMFLPbSpaKbFsmx7hcctLXnpmNoBWUQqI/3GxVUPvbAMAhR6w8wRXFj
         KZ9dBhAdzvc8D1Taz+rGi4Zr35ruQubgbvG5MAHfZAfRYIXjirc57Pt8SF/p2yfG+Zvn
         K/tTHX5wlT8ZrUEaM5kYmtr5RiTOdsjudGlsevx3VA7DjTq8QmjMRYHEB0+L2KU21b2C
         YwKZZE6NSWAM54NdCmlyJaBM8O5zDPJLzocalXyyRHyaeABk/T6z/ASoN+lpPHwoW0n8
         8vfA==
X-Forwarded-Encrypted: i=1; AJvYcCWq4Eg99PuE+fO8gSyFFGrs1eJH1zUjldD8EFEMjJdPR3rV0ryrsEWfCk70ADLK12dC6s0duUiDpEV9XqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DL5YMM5rFEJEnndZm1S+sgoz1pLYWvBCkKG93lQN5+ySV5fg
	+A1/ji8JV4TDYjC4amSD4EgQEH1K+8LRiEj1pQt9hO4y6Zw2bTKFbyidp1ja/Zo=
X-Google-Smtp-Source: AGHT+IGW7IqZl9Mpin4nsxqbo6HR3Y3Qib6EmFhulT1fG1XZoxfVQ6sWL1szp7/l8264Leo2fYTojw==
X-Received: by 2002:a05:6512:104d:b0:539:95f0:a05d with SMTP id 2adb3069b0e04-539ab9c7251mr5074412e87.58.1728309635246;
        Mon, 07 Oct 2024 07:00:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d2f6sm855423e87.152.2024.10.07.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:00:34 -0700 (PDT)
Date: Mon, 7 Oct 2024 17:00:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
	Arun Kumar Neelakantam <quic_aneela@quicinc.com>, 
	"open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: use only lower 16-bits of param2 for
 CMD_OPEN name length
Message-ID: <zdpszrr7lhe6bvnq3ullwet3pzfidnhfo3wlvfbljnu7q4j2z6@3romukxqjyvd>
References: <20241007044723.25347-1-jonathan@marek.ca>
 <rmybaobbmhmynz3or4uwvhdgqjrkahmkwz5ncct6rssnfpq4jh@ulqeqesixyhz>
 <8b050bcb-640d-4443-ca31-787ec5c02a7d@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b050bcb-640d-4443-ca31-787ec5c02a7d@marek.ca>

On Mon, Oct 07, 2024 at 09:19:05AM GMT, Jonathan Marek wrote:
> On 10/7/24 9:16 AM, Dmitry Baryshkov wrote:
> > On Mon, Oct 07, 2024 at 12:47:22AM GMT, Jonathan Marek wrote:
> > > The name len field of the CMD_OPEN packet is only 16-bits and the upper
> > > 16-bits of "param2" are a different field, which can be nonzero in certain
> > > situations, and CMD_OPEN packets can be unexpectedly dropped because of
> > > this.
> > 
> > Any idea about the upper 16 bits? Should we care about that data too?
> > 
> 
> Its a "prio" value, it should be OK to ignore it.

Could you please document it in the commit message and in a comment next
to the qcom_glink_rx_defer() call?

-- 
With best wishes
Dmitry

