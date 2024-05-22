Return-Path: <linux-kernel+bounces-186221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F38CC13D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DD1C21DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096813D638;
	Wed, 22 May 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lb9wHJRP"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C013D61E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380920; cv=none; b=CqOGW/DEf8Sp3TDuH0tuFTQHyEU8IQqSmrcED6DAq1nRk4yPmkiSEQSrsNZRye7mbNkuUlnKIH/JLMcuKNqkWcUo6iTQPoDqQ8TTy+sjfoswAyeA0d0jvEuoVF76b7rrBN7XqRrtD+KshKqNT0Z1NfMs1RCT6tu9kGZ0iGEq5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380920; c=relaxed/simple;
	bh=bdxw+Q0XGRmuFjdwhmwLig3zIBnPf0qvOWQa/FwvDVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OATT4Pe/ooVlyRG1kqBUX130niVuRMjc3yEJG8I1v+A02EHpV2LQ+7sXY2NmQyFs9MtoZUJXeUpDF6M4N4mgdmkC4W8u8V+UrKoAStmmQV3RbiGH2H/WamBKxiCmIHndWs0ZDEvcFv63BAtOPddd1r3hEG2u/0libOHxd/a6vKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lb9wHJRP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bed738438so48928967b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716380918; x=1716985718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVUa+HtknJVyE1LRWMYlqdPQQktkEpm5BV1SvyrxPpw=;
        b=lb9wHJRPvHUbkdRKmc1DN6IHkrnY+H4M4Wn6d44g1MYRn+D7vqJNFpXgn6a4sg1x2y
         I/S9I19BjY6n3lDpBJUdBL9Xcg0wUtzyl8ERef8luDwdx5szkwmRlWjenUq9yniqRq9k
         e7DXNW5GE+MfszupgjTcayR7EGg/iTVp3dMiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716380918; x=1716985718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVUa+HtknJVyE1LRWMYlqdPQQktkEpm5BV1SvyrxPpw=;
        b=VMU4Z98r+Zj2PlK0mJNyJ80AGInqRCQ6Kaluk8YE5beJto9xNGygmba1Ekz92ja5JI
         5+RgNvg0m3cUqk/DWa5qR1IF9xM1J48nLIet5HuJ1WbWQL37PJWV8aASBUL1cE4rr32L
         1FXAI1ZcHeyziu3oD5Fhsih12qzguhxxy/BR99icKdxf0qQUQRtIpa72ZZh0tu2t7QFs
         4Xjvm+DknUv1QI+K6fj0gBl6dtQsd9GvB9SpahJtNDVIFdUdOsIw9AN0suNtX6vLs29p
         EVEWg6zaOFvpjD6+rAuOxHjUUsirinPA4BJB8BjpwkOcwV35s6zU6ew1vTzl5I0KBt2r
         u/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXPVKGOzoIspB8vT2o6JAqmYZEPZfePctR3d/kXl3bJRCy6a8kdUEbau7eYa+6oKv8TL6RsPtxXfe7lkuKCJzbLqwJHKCgTKR7gWra/
X-Gm-Message-State: AOJu0Yx+wPG9e5sPyAMx3A4riG/ItVyhidTbxNR+P3FxF3fW4fDBDhkF
	/Wniwrl5bMezEBDr6RITWXaz+txiDB5NjjrUfC4+JvMdWjacj4AdRcqpEpZF7qPcp2zGtM2X4bI
	=
X-Google-Smtp-Source: AGHT+IH3lN4s0WUgUOuFW2RXeVCAscq6CsdllgbxQSYXJ8HOq4nr4l69rH3p3f4Rxv/QYaRiTM+8Zw==
X-Received: by 2002:a0d:f984:0:b0:624:4154:fcf0 with SMTP id 00721157ae682-627e487cf49mr17822927b3.35.1716380917819;
        Wed, 22 May 2024 05:28:37 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e5b0b25sm57650377b3.132.2024.05.22.05.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 05:28:36 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bed738438so48928527b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:28:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQ1mOQPpo+l4Nhl8JMTyPi3+wieiV//cNq7J1ew30OAAviODLiGiWjQYWviw9N557uvCrE2HWgcLglBZWcdfG4eRVJiCkfAWgVeQmc
X-Received: by 2002:a25:dc8f:0:b0:de6:1534:e0ec with SMTP id
 3f1490d57ef6-df4e0a760e3mr2044809276.13.1716380915690; Wed, 22 May 2024
 05:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-9-7aea262cf065@chromium.org> <5eec6d69-badd-46f8-9da6-a578d5f7c3ba@linaro.org>
 <0e6ad5e7-ab20-495c-aa76-77531a53d459@linaro.org>
In-Reply-To: <0e6ad5e7-ab20-495c-aa76-77531a53d459@linaro.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 May 2024 14:28:22 +0200
X-Gmail-Original-Message-ID: <CANiDSCuQtND+jbAAv0UYmtgO9g95qshY=HZVnyuraC0Ud_cD_g@mail.gmail.com>
Message-ID: <CANiDSCuQtND+jbAAv0UYmtgO9g95qshY=HZVnyuraC0Ud_cD_g@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] media: venus: Remove unused structs
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Bryan

Thanks for your review

On Fri, 10 May 2024 at 01:56, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 10/05/2024 00:35, Bryan O'Donoghue wrote:
> > I think these structures should just have the "[1] -> []" conversion
> > done and be retained instead.
>
> They won't have the same sizeof() then so ignore that thought.
>
> I still would suggest dropping the `something[1]` in favour of
> `something` because these structures document the protocol between host
> and firmware and therefore are useful even if unused in the code.

The structures will be in the git log for the rest of the days. So if
someone has to use them, they can recover them from there.

Right now, they are not used and they are triggering a warning. I
would argue that untested code is broken code.

I'd rather remove the code.


>
> ---
> bod



-- 
Ricardo Ribalda

