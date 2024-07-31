Return-Path: <linux-kernel+bounces-269915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6094389A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79508B22226
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6F16D4CC;
	Wed, 31 Jul 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YbHWtVbP"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535D101EE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463666; cv=none; b=qEtuASfrvKi9q4OviK5IFvZo4suREImnRLRKVlJPpISpjFK5UnDFzFXqpfwXwjmksofnpnJEBUyIJuLdNS1hPmvMgxiXRXVhdnTHS/TR9uVA4pPltDwSYRR+Nw9pDAX3sOVWU6HyiOmAPzfi7ygzmLDhMjAHhQRHUb3XjHGAMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463666; c=relaxed/simple;
	bh=5/FzbCoYCYVormMglWnKjh4aEoJ7A7JLI2hhC5fYIWk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LUes+Jd3pqaml1B9PdVTHN/RHXJpHiJ4qtGKoHSuIKtiSCuKvR3Pb7ORR8MORHZP4Nb1+9NJszJ7A9YVtWSDxYgtT1hycZ7usg2Tn0KUQwFOclBhACIUCOlaWKMaI93hDZ5JitcBmNjuNo0uXgtGHbqAj3uDJ/KAjE0HqympuvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YbHWtVbP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9e13ef8edso4137501b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1722463664; x=1723068464; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=So/9QSkze1y4ejM3Y8FPZR3gEKL0InNlYUt0gbOuwac=;
        b=YbHWtVbPJntuKon+IbTPT/vDhjoV2ASN+gJWbIgXucbyWee0Xw1lOim0oVvQgvr/nf
         1qNLXmCEJXTwqPgLgN8NB5PYdbYAdRMRsyjhSjuAg0FQVo4Uloo/+IuqF3AkSDM5hwu8
         xTTpVB4VAC7KRVJNV7ei0yC3QIZ20perSlWxYsvTxlDTNz4yX/eET5tnBTAZWTWxMrSe
         UF+0agmGuEv0yo8/JrXKy8oS6u616NUxMcFJZo0rBK5DKa1ifcG5Rm1TcGaR+HbLMjUr
         t5h6DlHGtcsHKGYYSUjgCKiPf5sK4VGiBxiQCycAwNSWBGj3uOSpbX6b1zRkG2aX3Ity
         Yo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463664; x=1723068464;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=So/9QSkze1y4ejM3Y8FPZR3gEKL0InNlYUt0gbOuwac=;
        b=M9y78ILRNSvWVaoCgrBhENKFWKkhyGGVwxCg0k3NtIh+WLreROLK8Graw94XIorLgm
         K/Z2doBSTASAXV7VovWGXOJJhi7W3dDKdmVssxkEbARsx5W63LmtbNgpHOkE17ygojeh
         3IBF1YLzqX0e9NUKAGnvNxlBSpib5kp1IR0u4t8/TtLbxfL2E6lzbmczE+aLG+757nvd
         MzcWwQOPzGqgojjmrnVQyLqjx+EI2bQaVFkI2oFNG83jMPawm/8ZJKAfN7IoGyaKl9a8
         2AW2l8OtxK10oZRHUoVdUb/RwYxl2rgFqoTp+nXGkOkeIw3MBX3bdKtU5koJgzSapq4Y
         Ed8g==
X-Forwarded-Encrypted: i=1; AJvYcCV9qSUgsvi8UYK/zrBfnpjkK0TXCemA5y29N+eqsUL97/ICvV6HLqGoMbwkEOqcsX3vXSd7KnmnVyDan7miScwGWpNjRzTPavCoe/jz
X-Gm-Message-State: AOJu0YxUWhs8Uio94PD0O3EWSfvO7pPVBEHay9FUSHlBcu9AghX3KsVp
	4818Yjp6T6CSPcrnzv3DlV4QghjWh2KfTOODPPyOIe0NEewwBbU+0BSlcK+DJOLJNGCrxwMl9t7
	8EFhaOqRTuyfA3oXEP0K9ogBi5ET7uLL//GWwWfgh6XipKWqydQ==
X-Google-Smtp-Source: AGHT+IHf/6+JdBOy0saPPGO8DOj4tULdpYpCthc5pvwq0MEaub636v66UIYgIZZHSDY3XUfadWNVZBHASBEOO9hzpPc=
X-Received: by 2002:a05:6870:63ac:b0:261:164d:685e with SMTP id
 586e51a60fabf-2687a756a41mr494529fac.43.1722463664294; Wed, 31 Jul 2024
 15:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 31 Jul 2024 19:07:33 -0300
Message-ID: <CA+NMeC-s6_aZYTMaLn=zsu4fhjVXQeMorPTXABJn41aS4G26qg@mail.gmail.com>
Subject: Re: [PATCH] selftests: tc-testing: Fixed Typo error
To: Karan Sanghavi <karansanghvi98@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 31/07/2024 15:07, Karan Sanghavi wrote:
> Corrected the typographical of the word  "different"
> in the "name" field of the JSON object with ID "4319".
>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thank you for the patch.
I'd suggest you transform this patch and the other one you sent, which
has the same subject, into a patch series.
Also please change the subject to target net-next and to specify which
test files your patches are touching.

cheers,
Victor

