Return-Path: <linux-kernel+bounces-216233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF39909CF0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244D11F2100B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE1186E49;
	Sun, 16 Jun 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebKJtK3F"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A1481A5
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533136; cv=none; b=q3yDlUdRTKTxpCVJe87BSEmpXkF6Q4x6uUihPoLLQzRNLLX3OsW0dkso7AcztlaU3KBWpbkfUOcZYyekywty6x9+NQRgpQB0Me3PUDp/05TJLH8JAaJg0Iu9FBM8tHI9mcufR//OVzqB+gGSVD3VVTGWs6UjDAJdJR6tH8lLs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533136; c=relaxed/simple;
	bh=dpSVKzcy8lgXSiApirUM1+EjWFhLJ8jcu2KS/9WFTlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdZpMXXJrQnr+VlZFNp5u6jlENBH6YNfCLnvYPO15xFJs8YMRuyWukACq1kMUy2YcTdbA+GH/F+ZyxBMkZy6Bo6TKJIDYMuaERi2bPvx+BqtzkNDmTsuG/lL94ow8jTIEp9LMa9n7qn6KgpiT6oJ5UbFXNZcqXLkZGGG6wqhr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebKJtK3F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c4c7eb425fso2826781a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718533134; x=1719137934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQiiGkPR1cOhuwccnCPSboJqnrnEfKZSO+pVGQ9Simg=;
        b=ebKJtK3FL25UQcVXLIB3UyWIpwXSuTz07wFa4L64FCeDhOh/FPHEJEW/z8xzI1x+wY
         /hjJfWYSTmIQIUsQ1FuNYVdVtgmFyIrg0zf9I+e4MEYMoj3zxhnIMw5f06psBfo0Y4gU
         lMhBhbIUz3QyT/OAUBJxqngWFwp5GoSl+sSiLT8GPDKvWxrfYxVI4bwUTMIWi4KhHEIX
         yIhMnvlEW/1Ae5FvXq84Nkbb/ler9c7BJBAalDw1gVKf8Gt/qVFNLcF9FGurG/h1cIdF
         bO/8yuWMGY2UuF76F8cb8Czz3tkMymH/sTtXnvUT3yYHZBHTTQSH3EwiqxcqSv6rvt9V
         f5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718533134; x=1719137934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQiiGkPR1cOhuwccnCPSboJqnrnEfKZSO+pVGQ9Simg=;
        b=SaFZJSlOTaF2dPuQXFwfbtwVozEqGFoo8mng17PQUTKX2I0bAK06uQgGgT3LXB1/6S
         xnLYFr8NsTYek+N1UT5a2Mp+u2uY9YqEUSsoLgX+p5yLOu3sAwIbuTsIayOCjwotfUzQ
         47Nqbn1ha8lDJoSQYud8WgYZ7c0PuSsPMc9y17P8Pgd2bzXbOivvB2nndQka+ARway3V
         8tf2wKvglPWoSZZnlTyxKJozvqQpfEO9K7YICwljkjH+gk6daQRBvf6XUPVC+HCy3YE0
         wlXP3aU06gf+WS7wgaNglQKfVjzer/0jHEoSttRmPr9F4IIfIS8zMt5f2jBfh3LeIV/v
         okhg==
X-Forwarded-Encrypted: i=1; AJvYcCW6DRAYq1O8jyJQXdmb0FuEh/SG4jGt9qU4Jjv1iA04/zlKZCv8K0og+P4DsLXRyL1PNTBy1JZhz4Rj/V/Fu1cQYQe+p+T5nfjUHISw
X-Gm-Message-State: AOJu0YyhchoETz0NlF01OJYoeZV0bVW9XIrYsTtZsGJYuRTTb6yAh47w
	LQrjNGbS5NtNkm7jFBel4KgmohsoiODn1UNFVoT/4TNJzLj0s8qpIQo/QYXkFg3brKL7N5P+ELi
	BMc+4gmgNGpsl5TwQpIrwQktgB4Q=
X-Google-Smtp-Source: AGHT+IFf0/ET6ShVs0FlDrOnBX8qXyLvnTl41W9j1v3eYDECrSVgXTJvMGO5X71rgiXTOtlGdATEdSjhJVn55YQMNYQ=
X-Received: by 2002:a17:90a:640e:b0:2c2:f081:f849 with SMTP id
 98e67ed59e1d1-2c4db1320fdmr6091701a91.2.1718533134157; Sun, 16 Jun 2024
 03:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406161537.8SBTYvQm-lkp@intel.com>
In-Reply-To: <202406161537.8SBTYvQm-lkp@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Jun 2024 12:18:41 +0200
Message-ID: <CANiq72nLzt65vonFv8s1kxcOd3rxOfcVUC3ApaxWJg8XjmOjVw@mail.gmail.com>
Subject: Re: error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up
 float (float): SSE register return with SSE disabled
To: kernel test robot <lkp@intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 9:40=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> >> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next=
_up float (float): SSE register return with SSE disabled

Thanks! The fix is queued already:

    https://lore.kernel.org/rust-for-linux/20240529093336.4075206-1-davidgo=
w@google.com/

Cheers,
Miguel

