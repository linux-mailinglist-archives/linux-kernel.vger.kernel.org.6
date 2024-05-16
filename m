Return-Path: <linux-kernel+bounces-181513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1EF8C7CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CB22870AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81216158A28;
	Thu, 16 May 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfksygcy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5A158847
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886348; cv=none; b=BQRFgBR0ZDMEukxt9y3dvy+lyw31rAj6Oa15HDFhRXuV0W7FIBDneFUqsEZsgGAnkdc9zXksbb2tu9009XxsAigcr73rfKa1OGeeuwbU3l3MwYIEx6dRb3jU9UJ/CkzQFDjobOwU/zgvrqJzrbs65xNvGYTZQo8iwehKS6i0/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886348; c=relaxed/simple;
	bh=H0Rlu7T3RgrJmIMBSQaKaUwNMaaEBGXcNd8GDQEoea0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oh+w916clHETdkagt7XYkBmoR2u6LKPRYhq5RnS7KP7Lg7611mOAEWQ+YbdohAqFu5tB1pOV9xPgaAadPExkP5JN7ovKVI3ij5HNqUyGfgKAsZMsZFw2Xt21jpxfAYPlZDYF5FrVJyN7VWSXHvJZbIJACU9s1foH8E/Yc8GIR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfksygcy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a7d28555bso405003966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715886345; x=1716491145; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0Rlu7T3RgrJmIMBSQaKaUwNMaaEBGXcNd8GDQEoea0=;
        b=jfksygcyo/DBplAECXXb+q10PQt9V486qrKOOo5FmftPrfV8T0QdHhEf0hU/FH+HAW
         khfN4lvVZLnUAkgD7Jtyxg+/832bPv9vdxeaW6fSRtIC6Ll7Wsgrzin7kumimc64uKnD
         eZ7Pirxt/hi1yy8MhS/O2j8Vs1pMZJrixtO2skLUJpIQeAEBBzgELAH9+u+cHyv9Ks4Z
         7hDxOSCP0fEhc9Uq6syfVkek3KeO6WEAo4FfrgCLesYv763imTeGaDtJXJzJb6gzIUCh
         kmzKAMuqiJ3YR1/6MVGzsj/nVFfOGrUxev4+V+Fez3S9SqmoG0Lxd9Qz8nA7i+Ae/4on
         iD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886345; x=1716491145;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Rlu7T3RgrJmIMBSQaKaUwNMaaEBGXcNd8GDQEoea0=;
        b=EIySCm0IrMRp4VAu0OUUUgdNzuV6HCUocU7yfqyAg7pZJRpr/OTpgAR0pAzckGwAIB
         iO4yXbPoPlMYQ57c3ND5XQWoGNj3KcEPwv+cN3vteoRANx5zrcK4LOJGY/G+jFuOIhaK
         rhH9gFrC5msvMpuK77YcKNJGAL3SnDSXSRal8hATRI81qhjEFi2QDBE58dxpjwxGgh8R
         R5laNnzELpUA0w0yY2/PVMeTtVyXfQXHW2bLw+/f+6OaWshBEc5a7XYYbzTm7U7ey3sM
         9L75WMsebMtNa2ywdSyS2doT9Rdj8HakRocfUAZILqYYpK1U1x2W3KIMUzOl6PyOSRpD
         P+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUNLK+GrO6jsMix9dkr969kAsIVaTbYpA34wOM2LYT+bhwtFEHKuMD5H9qwJY67N8r2acwLiipIr9X9xly0vjlqYI7odE2SU0+zkdzE
X-Gm-Message-State: AOJu0Yz1x1Nf2cvtPMBQvFFdNBQROElWULu2LR7c3jsWtcvb52t/PnvK
	zugsvv+3OJqb1AsBIb0nNqJ2wnNaueMGmcUqC5PbuTzJBxW6/NLlOgPa
X-Google-Smtp-Source: AGHT+IHV4zgBqPYSGcR0wfBH+SKzI7addG848AC+IwEJEiE+TDodxh4tOqDT2eE/7x188w9EhixXyQ==
X-Received: by 2002:a17:907:1118:b0:a59:c5c2:a320 with SMTP id a640c23a62f3a-a5a2d581b19mr1308915666b.23.1715886345355;
        Thu, 16 May 2024 12:05:45 -0700 (PDT)
Received: from p183 ([46.53.249.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm1013001566b.166.2024.05.16.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:05:44 -0700 (PDT)
Date: Thu, 16 May 2024 22:05:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Edward Liaw <edliaw@google.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 45/66] selftests/proc: Drop define _GNU_SOURCE
Message-ID: <4bbc6001-bafe-4db9-83fe-e03ddce1eb26@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c

> -#undef _GNU_SOURCE
> -#define _GNU_SOURCE

No! Don't do this. It makes individual test program non-standalone.

Right now you can copy it to some other machine which triggers test
fauilure, compile and start debugging instead of remembering which
stupid compile flags it requires.

NAK for /proc, sorry. I'd like to keep #define.

