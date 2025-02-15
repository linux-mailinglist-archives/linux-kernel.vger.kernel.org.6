Return-Path: <linux-kernel+bounces-515980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81007A36B87
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B95617025F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE263151995;
	Sat, 15 Feb 2025 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISN7Jzvl"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC9DDC3;
	Sat, 15 Feb 2025 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739588486; cv=none; b=uqpbX75TujyjkUqjRONa1DgVvjJJsxNAEKLPtx4YJ5EwUKjVVG5UBWC2XXc7YwCz+sGhA9rw0VHesLr49AB8lzUf1GGlJKr+dOSdMjTBlSEQSkgDe8aZbGgGc8Qp57cOAQ/FJIwr/SNLATl8RLbGv+ueAG6Td50RFBuggHQpyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739588486; c=relaxed/simple;
	bh=ydZp4TlIsqSmjYDiFlBz73Jriv+xKFTZ8q8q94UbOuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/pDm2oKi6ypwdjosMaG3JjyxUoEMqduvaGy69u2UUJN7wLMLRixN6cdvI/8pMjyOLx0tSxIOwGJcQ38dsbz5X2vIiJQ0he/HG7X1gFsWPr2sA0xFgxgTmLOfGyNG5gqGkV3QEKrBOh1+Q4QnZ+SJJ4Kxpid0kp29mqpRzTbsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISN7Jzvl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so4771643a12.1;
        Fri, 14 Feb 2025 19:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739588483; x=1740193283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYJ448LXGs52M9ufJR4pd9S3Z2faHguUY1XQCvleFUM=;
        b=ISN7JzvlmAdH/Uu7zv4yAWPFHGaRumy/KdRKVhEarvjhLSZrUzbLd6hC99ab2Vg8tM
         NKNcoPS8wjUXJ5Q5pqeEWRQ8zuezKHcyCDCoYcQwtZ2KvCMsWOYLlla82Xs6RF1oSNOX
         inI6ROFrY0Cdi2u7WOfftc+se+8ngpKliLQE+E5xDKfyC4Tr7WtJ8qRGRHKjAzqIGn0o
         +TxOjfy1xcFxafi0kNo1S0qo5SbdFOpRuuMYL8J5VtadRpAZdox5jr2Fk1FK3HcFI5tz
         cY+CgN+neGDwjNCXT2rUgWnbjb54PSJzEXuSld0q/cbGGhvqkhXY5rYgEIguma/ouq14
         tgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739588483; x=1740193283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYJ448LXGs52M9ufJR4pd9S3Z2faHguUY1XQCvleFUM=;
        b=Ox4/1xpef8CzvVOsgsOxaK+nxz03jwqtkBQ+hgTQhIEwqRit8gxYEIcvaJo8IlqVTn
         aenC4wyo1Tqiq5dNr39dE0sY77WI0xGhQtakA7NUVSc/XEDGZ8U75PaP6CB5qNv8VbIs
         QF8Y/A938sl+CANsQ31kUJXn8YLTkBO4+bkVS1Up93zHzmoFpz0H9PJpH3O6wRUtWbZD
         iCTCR1bvXEc2h8HWY2Mlzl2kzd+bD706bDU9SMWiUb01wwnaz7EZGWMQ0PgyZi5P4/MU
         1JfbA/b2WfcIj5kqG9PTNWg7XFQoy8bNEWm0MrrGnA/IHcWmpORYnvCGRjmdIcT2Jskb
         /kMw==
X-Forwarded-Encrypted: i=1; AJvYcCWsKo2mclAsGw512BYUqnAceyxFTjzR4oDKfgcHtsm2mF2lWJt4UCsDZGRY03zUb814YhIQQUyf68+NGYOT@vger.kernel.org, AJvYcCXn++UUIx9nT7mb8BgvGG0WdnSWuTzUHjkFg+03ltYlkwIjhjD9uv6jEK1J54MCF3+NViqPIoTGCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfySf7hy5erzQNPTiRqXLOuTjTLLoN8s3FJi9iMVZUuHF4g+8
	2r/NI8vNm35M0ozRTce/sH57DZsYD/Z7YaFJAxzsV3Mna4q5EB1oogU/0n0Jt83f9PJQMTkmhSH
	TGVCL6vkvkcnL9sFk7Y7zmEtURjaJ7ywsxdg=
X-Gm-Gg: ASbGncsatKnSKY1HD6p425w+IOuQ6SM4VB8cJnlKDQ1GeUon7zNtaynS5SQgqNZtI9h
	P3fBZ9OFXL0bg31q11x4bwYx5TnWWfRjCKvorjas3KZ1ZX73F74PrCeMZkd8zDw3SR4CDc59Hay
	k=
X-Google-Smtp-Source: AGHT+IGsOSuHyhJLcQBMlRwELDfDCNC0Vv6is2jiG0l+8IKzR1sa6rTqybII7zcDlwM7n0LHH3a3gpnSQLxxEKkDwTA=
X-Received: by 2002:a17:906:c10f:b0:ab7:97ca:3276 with SMTP id
 a640c23a62f3a-abb70bad02emr109166166b.25.1739588482564; Fri, 14 Feb 2025
 19:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213054222.21776-1-alexs@kernel.org> <20250213054222.21776-2-alexs@kernel.org>
 <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev> <CAD-N9QXhmNBUFPfo11-h0H0Du_JFNX_Qxcs8aoesW8=ABgneaw@mail.gmail.com>
 <CAJy-AmmZAuZWUS5TTuSGg5y33Q7Q52CGQ7en5vg_eB2W2y_s9Q@mail.gmail.com>
 <CAD-N9QXRjr3yVtyucRbRJqXcJy0JwR=UhcNoHPbs3MQ2JcGKdg@mail.gmail.com> <87bjv4zfsx.fsf@trenco.lwn.net>
In-Reply-To: <87bjv4zfsx.fsf@trenco.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Sat, 15 Feb 2025 11:00:55 +0800
X-Gm-Features: AWEUYZkBodELibF3aDkTVu_Y4y9XuvcTqtZyJc58hZ-Em56EeadVnXiuBJhnnvU
Message-ID: <CAD-N9QXn5m=9xWaAwrex+ahDayArWejXQjm03JkqqNiYMWfieg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <seakeel@gmail.com>, Yanteng Si <si.yanteng@linux.dev>, alexs@kernel.org, 
	Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 11:50=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Dongliang Mu <mudongliangabcd@gmail.com> writes:
>
> > It takes quite a bit of time to finish running `make htmldocs`. Grab a
> > coffee and relax while you wait!
>
> If you have not updated to latest Sphinx (8.1.3, say), you should do so.
> The Sphinx developers fixed a big performance problem, and it's much
> faster.  Not as much relaxation possible as once was...:)

Really good news. Let me upgrade my Sphinx.

Thanks.

Dongliang Mu

>
> jon

