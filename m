Return-Path: <linux-kernel+bounces-353702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493DD993150
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13864284BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972451D90D3;
	Mon,  7 Oct 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTF5R/a5"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3C18E055
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315278; cv=none; b=KUSXnzdhkZx4ofWNIMkH/9ZMeMDpW8wmtwUBlkY8IkNNGb6poNcjpXyhOGEQGxuzPSH7ecRDsykklRQ6fb1ECgRucdrTR0NMWA4t8xhByg9VvdVzhPPXm1gxYTH3UFc4Lnc4H8egc3S9nLIEMn8CAJCu+irHXZDkCkBeFBf5zfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315278; c=relaxed/simple;
	bh=sRRg6piG+3aTg+1ltOa/3wYaOzLT3DJc0mq4t5Vw4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjXQ+cZVSNE/7h3t2ZGUlYnLiFwbVS8iPP5sbi7EHAaQ3tEaXj4pc7rGn6djPZ2DIRfo9FOizkIt3TyC23nlKjsj769rL37T086s8u3C0SzEQcwXinJezomiu9JGBsxt/gomF6SBUN4JnciS/6E0nx8L/845F32qfDqWjzzo0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTF5R/a5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28a083d531so2298989276.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728315275; x=1728920075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWcDwMxqGGnJeEIPc0x3JFXLhGz0Cxxlgi4VrvXAYyQ=;
        b=UTF5R/a53TuG/77WH5Pw3nJUg7n//ndUbiLgUQPQV3QzKvdXnOmlyqNHhDqoCtwhi7
         s8yFsXE2Je/NoFl/OxWdJcCkrmEr9bZpZ85OA0Y2Zf6nhthTNaORxrb1zfrxfv8td6t2
         MdCeB9A2HDQhVjG0pPyXlEy45Xem/XppC4TAA4xvqcXSzjZ3E1sqOnzTSqJHVJiEmMb8
         LfYv//9XTq4GLsADpkrH0GQV/5OjE+GRopz09QrgnMj4MobqRo9aKDPc1vLzhYp3jTxX
         7I9oSiVsAgIhFIX7O+ycJe5HM2khwQ7BmzwvhLEgF+1hJxXTnVgHim1yAdEe8LdKIWJr
         1lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315275; x=1728920075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWcDwMxqGGnJeEIPc0x3JFXLhGz0Cxxlgi4VrvXAYyQ=;
        b=rY9Bp5NRJHgbIsqk9r7uxNjdiQW6rWnxszxcqYOmruU9SXmHh7Wc1jYXVye8s2qKU0
         RLYw6eK41nc+7WwglFVLVJIdNhEQTwOywuPWyAEpoOtt+bJjo6M34GVR0xvkME5a0+3D
         afpT080GwgOTRQLK1vs3Y0yb2ktnI83CRSLsXp/7meUt77sHakf8j0cX3Mfop/nfaq+M
         HD98uZJgQ90eFM+zmSYoZTf8OEQ9OBAq9mpreufJWw34A/5OmAUSvVSM4Wr+wmRphojS
         1pyBv8zysjWkVtcxcuTmL6vrkhl8g4M5G7VkJIKlHNugWUBEVwuVoU2FqjsLfQ3Nf76T
         yydA==
X-Forwarded-Encrypted: i=1; AJvYcCUQN6abOgulNQgdrCBzmit6ntGGAHrJJkNwxjGhUT40wI8YvKQCn8j4BSgGqOWn3rsxmFa4x1/OpoJOY34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVq8nvdhBD0OmT2BA282TMErQKmIGbh6KLrqc8JfaV56gx3qzf
	8s9cXsudCnuZPZyjDE87q0prU5VZhfJktG8zM+2fAS2Do0AhOVbQk+3B63ouIgTCItmAeET29uv
	gtKllXN69s+pUX1b5vHWyJFt0JCR3AbTN37KTAw==
X-Google-Smtp-Source: AGHT+IEJLEcH0O8UkVxsEgmlUswd0019MM6C0rHCgsIZpGEEbxovs4AhtDVb82JufMnhLZNKSxzuqQu7Kq4+iELR25M=
X-Received: by 2002:a5b:181:0:b0:e28:99d8:9eef with SMTP id
 3f1490d57ef6-e2899d89f9bmr6194074276.2.1728315275354; Mon, 07 Oct 2024
 08:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Oct 2024 17:33:58 +0200
Message-ID: <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 12:28, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1-#7:  for core
> patch#8-#20: for sdhci
> patch#21:    for GL9755
> patch#22:    for GL9767

Patch 1 -> 6 applied for next, with some minor updates to patch2.

Patch 7 needs some more work, I will comment on that separately.

I am okay with patch 8 -> 22, but since there will be a re-spin for a
new version, perhaps you can run a new round of checkpatch.pl to see
if some of the warning that it reports can be fixed too.

[...]

Kind regards
Uffe

