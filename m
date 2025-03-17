Return-Path: <linux-kernel+bounces-564719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1245A659BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386DD1895D45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DA51EB5FB;
	Mon, 17 Mar 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=semidynamics.com header.i=@semidynamics.com header.b="uXYHIuLx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560C1B0405
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230873; cv=none; b=WygMv7bfxqcDpFsstVZPzNEAgVnwkCsS68EJiUT1BC+qlwsin9/wAO5yjpcd7ppmq5OSyl2mdmmGuxlpm0dT2qjGd4/91DepCBA53yRw1v80snRyDjtz6wLrSDXoYA4a3Iv+wHUNI+NNJreBO12u069ANDJla3CQ3xqqvikHev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230873; c=relaxed/simple;
	bh=sHArdzCJ7OJGYmSrli5/QOc0LfBoQ1QCQ+1FM37WWf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQBTpqRPYkQxrHejz4W8tpH/VyJXCo2XzU7xsGAMvV2r+YT7N88wZkCsIwVAspba1DFwm8E4zEgyEDk1iz19Gyjq+c3D3FpS+0bOGos4mFgEyflr1/hviddRWnuGGJupW7WJkwpzjipOrkKJXn7GsnyE4hgHODlP2gijm2cDK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=semidynamics.com; spf=pass smtp.mailfrom=semidynamics.com; dkim=pass (1024-bit key) header.d=semidynamics.com header.i=@semidynamics.com header.b=uXYHIuLx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=semidynamics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semidynamics.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so580162f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semidynamics.com; s=google; t=1742230869; x=1742835669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03Tvy48TmAOS+7xyYgaARhLkJjCoqndvpt94zVo46wA=;
        b=uXYHIuLxTGxpzzlGevgVNDTlVbeW+ULBK4zrey2nmZ8Y6F7ziyJYvJa9dbCjvFKIrd
         e1IXBwTHAVAwVFctmOX3bTtHTKiN34rcyYIpG3xZBM0WnUz62bvNRQWMuLuxzLXrXZQb
         O5a6iiROVF0U3PPzeP1iylQdQktByxMzMGC+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230869; x=1742835669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03Tvy48TmAOS+7xyYgaARhLkJjCoqndvpt94zVo46wA=;
        b=BVvdAmvlab3vVBmKFAgzyqyz9kalJAEuj2lLtr0m4QoaI/kYYvU6cVVy1o//qeVXJU
         PSACsBAiNf6GHinz5qNoua0QWuHnse8SLGnUuseVCVsKuSUelskYX98BFulDj3zsrMKj
         7eV6RHTs8kzCentZozxVxULJrtHwkWnNDUkbQTyZCc2Rf/xpGChDQc58nC8iCqUTdl+J
         K1gg1EFmWpPSsltuXlj5W4WltpdgIAAA9SUQj+kKy0IHMgVHAhWuKuTvyXHDpa41pkYX
         bC3OkuDcKpG0yPmuqrz2D/NkfmmgdRJecUxGJMBu3F5Ctwg85RMqscVPDWZ4ZFywzJVx
         fgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6f1q1N3Hbt0ypRAR6OKoIghnfIdJAIrJY4P/Bowp7bm6Rewrd4PjIof832T2Z1nC1yVius7AUJt2lMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+NEqTNJmNqX6oB2xqrUyeQoJrK5swr43Cz5FGoZKO2RlNNbS
	zULXnew3ojXhoIzcAev7h4LUMDn8LYwJe4Rcaa4Spx4nTcdFHAejsNaYw1Xja/8sEnZ+XrH8ncl
	9hiY=
X-Gm-Gg: ASbGncslRQh/MS55qMdB+jMohB0FixM8B06F8qRN6vru9xzsMgA2VnoVLsOQTWEVSuT
	zMNaZvKIR0U6lGhTSVL9XA7H3djbDKSeOKj7tu1BGr9huveNnCP+voGODYmBih6VJ66rGsLZ3k7
	fFvLw7XJAKl/yhI1BlSNim/ZOxRWi+FdnNO/E+/0RtWaj2Efwwv1cCCIRP+ZUTAc627M34Ed2EK
	zX7jCxfrw3WKXldwmlJNYtc+2Akn5nJFUCVcmwYtavdFCtAg1q8DCIm84IBZ6ykgGu3z4KFEaJU
	0UUeqQBoJq7XdcaHsPmcaLAjqphcPhgXs6bNjPLEGlcCaI7mJyIpbNknSbOjonabT7I8HIxR6kw
	hBlzMBd1mzmlh/Vsxrzy9QpEImrQt3cRakg==
X-Google-Smtp-Source: AGHT+IEsx4LguvEPk377tGVp1MsuI/r0EPZ4Ta/6mmlTKMUYfLpwjbwVZT7dwz9Y0SbEIi90HwutDg==
X-Received: by 2002:a05:6000:1568:b0:391:cd7:82f2 with SMTP id ffacd0b85a97d-3971e2ad5bfmr5169031f8f.6.1742230868767;
        Mon, 17 Mar 2025 10:01:08 -0700 (PDT)
Received: from [192.168.1.46] (216.red-79-152-37.dynamicip.rima-tde.net. [79.152.37.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df339asm15330446f8f.3.2025.03.17.10.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:01:08 -0700 (PDT)
Message-ID: <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
Date: Mon, 17 Mar 2025 18:01:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
To: Dominique Martinet <asmadeus@codewreck.org>,
 Ignacio Encinas <ignacio@iencinas.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Sishuai Gong <sishuai.system@gmail.com>, Marco Elver <elver@google.com>,
 v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+d69a7cc8c683c2cb7506@syzkaller.appspotmail.com,
 syzbot+483d6c9b9231ea7e1851@syzkaller.appspotmail.com
References: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
 <Z9dBfEf0naCsNrNv@codewreck.org>
Content-Language: en-US
From: Ignacio Encinas Rubio <ignacio.encinas@semidynamics.com>
In-Reply-To: <Z9dBfEf0naCsNrNv@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/3/25 22:24, Dominique Martinet wrote:
> Ignacio Encinas wrote on Thu, Mar 13, 2025 at 07:08:19PM +0100:
>> Changes in v2:
>>
>> Drop unnecessary READ_ONCE in p9_fd_request (that I added in v1)
> 
> Ah, sorry; I think you misread my comment for v1 (or perhaps you
> disagreed in the response and I misread that!)

Yeah, I disagreed. Sorry about the misunderstanding. As these are not
strictly necessary I thought it would be best to not add them.

> I was thinking that style-wise it's better to access the err field
> through READ/WRITE_ONCE everywhere, even if it's locked; so suggested
> this diff from v1:
> ----
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index f163f6fc7354..65270c028f52 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -192,7 +192,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  
>         spin_lock(&m->req_lock);
>  
> -       if (m->err) {
> +       if (READ_ONCE(m->err)) {
>                 spin_unlock(&m->req_lock);
>                 return;
>         }
> ----

Got it. I'll follow your recommendation for the v3. I'll reflect it in
the commit message just in case someone does a git blame and wonders
about these couple of READ_ONCEs.

> 
> OTOH, looking at this again:
>> --  if (m->err < 0) {
>> -+  if (READ_ONCE(m->err) < 0) {
>> -           spin_unlock(&m->req_lock);
>> -           return m->err;
> 
> There's this access out of the lock so perhaps this should look like
> this instead (with or without the READ_ONCE)
> 
> +       err = READ_ONCE(m->err);
> +       if (err < 0) {
>                 spin_unlock(&m->req_lock);
> -               return m->err;
> +               return err;

Oops, this is embarrassing... Thanks for catching it.

> Anyway, m->err is only written exactly once so it doesn't matter the
> least in practice, 

I think this one deserves a fix, I disagree :)

> and it looks like gcc generates exactly the same
> thing (... even if I make that `return READ_ONCE(m->err)` which
> surprises me a bit..), so this is just yak shaving.

This is weird... I'll double check because it shouldn't generate the
same code as far as I know.

> I don't care all that much so I'll just pick this v2 as it's more
> consistent, but feel free to send a v3 if you have an opinion, or if
> someone else chips in.

To summarize, my plan is sending a v3 with the couple of READ_ONCE you
suggested and fixing the unlocked plain access.

Thanks!

