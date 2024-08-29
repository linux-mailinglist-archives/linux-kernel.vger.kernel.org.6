Return-Path: <linux-kernel+bounces-307373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80729964C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E524CB241E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95EE1B5EB8;
	Thu, 29 Aug 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROhFhDPO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E344DA14
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951123; cv=none; b=OmhIrjm1b0NZCtE/B9gGnzkwlkBUl6xuVqZsg/6HQm1nYbnNdW76BoglJ+9jc/cYbILFhZSfZv6xj2UYiEXXEStJFvpTK98mur0WdduSC5fOz2bkLRlObV1i7KmaK/LsyE+slrGWXGN+3lNc6jZ8HzzLo+ix5sxMSDikTDA1qAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951123; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1tGYWwFcyhAntwC5wYF+OhtKHgFlr5ZQOR1BcpP8Y2oy6MfslCZu7h3Z29N8uUuGe9qJ8ZKy59k+sH1/K0I7rh10OKXkbOZOm19w74os/OSz/r09z7VRwZq9YkZOtg+cWD4qE5mamVf8sdpUWQ1erHN3o7LsWvBvbRHk2i33CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROhFhDPO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42817d3ecfeso135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724951119; x=1725555919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ROhFhDPO9Ll9pWySk8+1RNzrFAIkqvOHeAt76Sekt/2Nq2RgyGnHOrg06nVAwJTbbx
         zAi0uJwwJP0jqEYMfTHLkWaLJ2gekVim0k8G/dT0p2KPEwnnDBxr8vGAEIAbWGgwydbJ
         27gRXfuhbdNIvrexgxiNmeLdRC7iD8eL/W8DICUJu+ZkoPpVwFJIzZtULYynfRQ7WJSf
         hf3JckSyM3mS9++wZHTI426vRojfg3E4bT5gEo9V8aflq0OYneGz+LtgkdyczysS1TMQ
         xYqLj5Joab5nUxH9a9uJl41/gt6GcyBRtoMAcugUPwyUekYoCs3c/38EOqb5F/7yf3PF
         4aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724951119; x=1725555919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=r23+fQRdbkihyBqmPUbWMtoQabWyAScG3dXl5tYvQ0u4vQwhVVweNpwSIDx/YGT02N
         6j7Gb5XduGBeIt6j2eLzJ45HYal64j9qQTqMZ0wjN7r+aYt0Tj5KSJx51AwtabVcZQ1l
         5v5EJ+vLMfjv30NqRmP7aczea1B/wWiRe5jlgOTBlB6RsCq4tTDKoWc53vQ78PR1bSeg
         OUY+VoVa146K9vi374aca64PA+UWubd4E8LCCFxNElONd0GyI7PeO973FhMarjh3Vpuy
         emF5o35+WuuQmASWWUA4nVigsoPn8yOwENRm9bM3BYaY5LV6I4je9JW/QCFZfqT7WLzb
         64WA==
X-Gm-Message-State: AOJu0YzjCMys3fjcx0cjkuOtmi1KQIoT5JuaRx4lcZ3Nrr2+Bo6FleOe
	UfUxLlnneWkA6zw02+x9GujGQq/8tatLXQeYEc+ihYhK0XU0JXu/VMrcsovq3Omtz+jt/+yNJb2
	VAJLDOx5mDkFvcKDulhHUCW9+qDK+QEbFtH0q0men6IlrkjNv
X-Gm-Gg: AV9I1ZT+I66w0VnT5o14ZFWn+6R+/ebutaXcns3KimGD7AqFzhWgTju3brPxnVZGfzk
	2Z5m0YPqC063wcjNglBVaNnarndFInTKndKGZmCAvyeFMpEahp5NFrupiHUA=
X-Google-Smtp-Source: AGHT+IF8ncbv3hPX6txBwjD+mljfVJFZjCz8WD9pS5r0ChWeEb3HcbLEeUEQAMuL4Kr+bb+8RiZA/+ov4ZUA9UxFSLs=
X-Received: by 2002:a05:600c:6d12:b0:424:a2ae:8d1d with SMTP id
 5b1f17b1804b1-42bba2d4b89mr12755e9.2.1724951118768; Thu, 29 Aug 2024 10:05:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFs7P=jk=wfo0nbHzqd1NrGX3NKpOezD4-u=nAMqzq7mq4Lidg@mail.gmail.com>
In-Reply-To: <CAFs7P=jk=wfo0nbHzqd1NrGX3NKpOezD4-u=nAMqzq7mq4Lidg@mail.gmail.com>
From: Joshua Pius <joshuapius@google.com>
Date: Thu, 29 Aug 2024 13:04:40 -0400
Message-ID: <CAFs7P=jPqv2Zr6Fnw584TKhj5joBRt7X7gMidE4MiK1ABAMiRQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: Add logitech Audio profile quirk
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"



