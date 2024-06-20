Return-Path: <linux-kernel+bounces-222968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C52910AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4FD1C23637
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B651B1418;
	Thu, 20 Jun 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/+tHuCR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC91B013A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899268; cv=none; b=d0sXecmXy8AzBODJVTH3B7Tne3crNXuc9DXrOmJ41E0zfNqFxipYgkinH6rAd5c8QMIhMAdb+JNKyGpOQMyFbEMY3iMYlRQeq7tAm1o86MBuws/moxhHFwq99zDyB4yUv5zuak+8WORnOO3MUk1uCaEIxpa5EJxTlkGC2tv+KNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899268; c=relaxed/simple;
	bh=hTqdjQ7Qi7hrrGxMOL3oVhnoPLode3S8RCGjK7+oaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS3z9laGBDGxXSylIXX2w6I6oG5G90fYjDeKL5dJMs10b4URv8yTTM3zE+DIgBcw1Q1Z5mi+ZFCpcl7YF8J1QSGhTdGqJlMYdbigGcylzuD+qXY6kUlLO2liqhEEVjImedepi+qNWOvWYkmG5ngLWefkRieOvsTuX+jucahRufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/+tHuCR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718899265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge9wVg87VaRL3PDUR6ZA+JS1REZ5t326tgMiEDsgJFg=;
	b=b/+tHuCRW7MPfGmKyB73G0Wgcz6W3wQZsQbGmZcIxiH9aTWr4BfzgDwcZ4aO2rcDC4CyoL
	u1l2yYT3Eejh67yuknS2m6PvJSiBghPMFFxu5XhekPyGneAR9fwkqDK2u3Ze1e1GJ02w8C
	Au2z30jvWipWorQTXtPxID/2hbkxL1Q=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-cSP0K5bJOo6gce94FoxKqg-1; Thu, 20 Jun 2024 12:01:04 -0400
X-MC-Unique: cSP0K5bJOo6gce94FoxKqg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d23379f6d4so1109404b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899263; x=1719504063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge9wVg87VaRL3PDUR6ZA+JS1REZ5t326tgMiEDsgJFg=;
        b=b6i/Kqw3IM3awT/as8AcZdfwDOcKwy+C9Uh83E3wsfrP64air2AItH/wjgtSZFaG5E
         3ptPxZaWkbxUu3wyqTL3a+Dh0F1IzBPEQd5Th+dD+MgQeNHAgppI9m/4tkaKVIdulG/7
         q04PlZxFrLv7g0iwYOrjCD6F1K5376SF62PDHW+/3/1XmqCZuhyAV5Qc2oNgzNAVHArI
         f0cuZgJHzlckK76s6nCMuvdOi/GExSMLqriD4n9sMUjDidH/qOk5u4E+DIOhe7R6PclC
         6Z9iZxeIY5nIvC3bkZc8vF5AEA0h0Hh4tjPUNl7sr3j2yFFyTjlG1etEQ/aVk+8tpkUP
         5YiA==
X-Forwarded-Encrypted: i=1; AJvYcCWnYjQbwnZ1NurvqiN1EpbBb0JmZ4iqZORdjEB1SrkVMFFW7l+4l+hfg4uFBW2FiqZfgWNinM1AtwdZTQ/soi+ijMA+c0Un7Y96DBkL
X-Gm-Message-State: AOJu0YxpWdr7SS1OHD3g5+WrIym7MGgS1X0MJAG1mHstm9LaJvFJoLxv
	tmd1LjUQJ7dpciZPpRPdv4Rqc6sExnxTtTM74ZQPT5QhX5EoYeq4euVAWgKXBTWl9umXcWW3n0b
	L4hLlnHNkDtxji3J6ORkelJZd5lfSsH4EnbcgmJBgCWzSjAgUnxX4HTYGuTIQhA==
X-Received: by 2002:a05:6358:6f19:b0:1a1:cbe8:be76 with SMTP id e5c5f4694b2df-1a1fd657194mr718534455d.28.1718899263419;
        Thu, 20 Jun 2024 09:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrAQoubwE9GNV7F+9zyFogOGxSttJFumzX4SRRsenGs0mNCuRfVp3c/qRTDLVFFmBItzi0fg==
X-Received: by 2002:a05:6358:6f19:b0:1a1:cbe8:be76 with SMTP id e5c5f4694b2df-1a1fd657194mr718497355d.28.1718899258167;
        Thu, 20 Jun 2024 09:00:58 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe2773dsm708132785a.99.2024.06.20.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:00:57 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:00:55 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sa8775p-ride: support both board
 variants
Message-ID: <eewxzrpcvwodj2ntiopezcjud6hj4fhi3ct7w3tdrin3ds3jhb@evuaplkq3477>
References: <20240619183255.34107-1-brgl@bgdev.pl>
 <4df2a52c-c21e-4da0-9ca0-13f28e81018c@linaro.org>
 <CAMRc=Mf4dZHMyexj1Xaw1dMVw0OT3=1t8OMfpHCB0xGJ9JdvSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf4dZHMyexj1Xaw1dMVw0OT3=1t8OMfpHCB0xGJ9JdvSw@mail.gmail.com>

On Thu, Jun 20, 2024 at 09:07:05AM GMT, Bartosz Golaszewski wrote:
> On Wed, Jun 19, 2024 at 8:50 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> >
> >
> > On 6/19/24 20:32, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Split the current .dts into two: the existing one keeps the name and
> > > supports revision 2 of the board while patch 2 adds a .dts for revision 3.
> >
> > Are both gonna be actively used?
> >
> 
> Yes! This is the reason for the split. I initially wanted to just
> change the PHY in the original .dts but then I learned there are a lot
> of r2 boards in the wild at QCom so we need to support both.

For what its worth, I've got access to _only_ the r2 boards in a lab
right now and use them quite actively... so please don't pull that dtb
:)

Glad to see some movement on supporting the newer version I've heard
about but haven't seen!


