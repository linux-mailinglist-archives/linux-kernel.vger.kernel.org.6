Return-Path: <linux-kernel+bounces-176068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41948C298C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C80B253D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364CD3D982;
	Fri, 10 May 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9o3owcH"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EC1F954
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363267; cv=none; b=uvf3DML/yUz6AlM3C+KZECWwVwlwA7KSNOgETHhvWr4qZ+2lQKv/V6ct4RPwDTcyl59CoEyjrMYM5gzLz4PFVPWQI6yYzTRF5btMObGJED88iG6ZnYOqk67sIypqfLnzfL97CG8xL3h2NwHQ4OBjq82zpJfNV+sKx5V3h31iOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363267; c=relaxed/simple;
	bh=wtIQIip5nVPfkbjixVWdphytuwonMdaHcOLroeIqLNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8sju3OKvbdBe+gb3sGpaQC6rdVdDOceo/pxRB+V77ZMh6RS2WjrahhG0KVdVt+eOlkJjUgIzgiGFZGUzy50giR/lIjQAveqg7mlY9CYTaugb4EPsBjlJv1UZkN+Qd4UIiCgiWDK54sjH1yzVck1TluJlZesrrGMRMOwwxGOX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9o3owcH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso789a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715363264; x=1715968064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtIQIip5nVPfkbjixVWdphytuwonMdaHcOLroeIqLNo=;
        b=s9o3owcHBlN0toIX6BKL0MzUXBeLlkQL6SZ4zEQE32E0GloumirZ417QDlmBZ0NrhC
         sH+xN1mnTienVbnHSErnxstvVIxfJZKzL/Wu9aywNdItoMJtgALS9esesmit1Tska0+z
         nZ5ChHFtiCio4iprFxbhFhTexHx4XzDWQE3ENOgJPmgRQRIZKdra6Zy3/vZDOR5sxTPP
         35MVlV9XdficZ4H1nCIOn0PVd3RX+Gmj4ryhgB83Zr/ci2HBWXOekQaclnTl1xMK5kbQ
         CjCpVh+2Wsl9REFxg0slxrmC74vhhnrpPboC7nU2flYzmhodqr7RY8L6/FT3W7WLYH1w
         sTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363264; x=1715968064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtIQIip5nVPfkbjixVWdphytuwonMdaHcOLroeIqLNo=;
        b=fN//YnGSrspPSetC9BH33eV8FeJiW9rl+lFn7XffBM/XeQuBMT3SwwRm+a6iixLkGG
         0uRg7oGpdtBIWLvOyp/HJJ33R8f6h+IBmK8TmHwZf8meck3sC8mt1+o4J1F0BU75sRUU
         LoHCDJmBRVBPSr6YktSwkhFW58FRtKOEtag8/chMq0HV+DGdRovkGjujgd0Ei6Ul7GjO
         5NuU7RcB0AfCsTSOmjny+rD4yfhEojhTw0XdEQMHJstOV3rKjj/sGSyzKEkdeqGCrCwo
         PCK8fjqyLu7Os9UxyEnpfe+19yGnzeu1o/92q/594SzofV0JstTuMFjIkNH4XiNHgQY7
         OUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVerYR5bHSJin+ACs6YiDFzMYQIcS9ldj823mxR8IeD/RpDo5AJvDjp1eukZXE2dJqjp4NfKNXo9GJ+eJWgta0WFmaUOduES4+OiZ7C
X-Gm-Message-State: AOJu0YxKjWosLZENTJQiZZPp2YOwKcvVW6zh+vwskXevEAJ/P5aziOHT
	g7JB71T+tpBddmxJpKAb4BlspT57ukEKbVqhy0Ze0/Kep29patMpxcU+IRgcWxaqS26hhk2RPRy
	7X/f7tnyq8EC45wvjA8mxWju3NsVTUnqcM9ZP
X-Google-Smtp-Source: AGHT+IHa5FsJxGeGgllWY9Q4tH+ll2VsmZa3DhLaRjKNVSrW18OHO9wNIjfKJEwokkqsTG8piczzmGTMpNstjiLBz5M=
X-Received: by 2002:a05:6402:1e87:b0:572:554b:ec4f with SMTP id
 4fb4d7f45d1cf-574499eff4cmr162a12.3.1715363264154; Fri, 10 May 2024 10:47:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503003920.1482447-1-jthies@google.com> <20240503003920.1482447-2-jthies@google.com>
 <Zjiq4PrL2ju8FOUz@kuha.fi.intel.com> <2024051010-hungrily-scholar-7d23@gregkh>
In-Reply-To: <2024051010-hungrily-scholar-7d23@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Fri, 10 May 2024 10:47:32 -0700
Message-ID: <CAMFSARfBu1vBbuA-jMgD0fWJL1_zfQ2X1P0XB-ysQNrJL7+B5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the feedback, I'll post a v4 series fixing these issues.

Thanks,
Jameson

