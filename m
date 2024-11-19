Return-Path: <linux-kernel+bounces-414539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E6D9D29F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26264B2D219
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F91CF5F6;
	Tue, 19 Nov 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="i7p8PtwO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4F1B6D08
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030184; cv=none; b=FiRJeq33IuZtSChNC5LpexKITeXuPunDrjnEkJGU4Rm/8vB8nY5i+k8s9eBhCadBl4Bz1fOH8YaTb0e98SAkpYVcLGNMsRPOGzYwjGpKoSdaGesBPawU2bQqDHjrxWKlclBEMcmOSY28iFHjg4YGWT1IEt7X/NYHMQueCi3uqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030184; c=relaxed/simple;
	bh=vUOWqpyC0v1hfZq0YqQxl/R5gZipGA6Ln5Fcfw4sWKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRLV3AQiMDT4afF1TvTeLK3ZjwSDruvasl4QsmvVUpluMmkKvJDlbUOEIKhUJx2MHu3E0899Oi6Ng6CjMPd7Dx/VpITjdG0kjzLx0Yf7MrTtP4Ap6H2RJwrpGM/8XrllDJi3NurriOBv4Pmk+zsptNpS7LeBsGDcD9ZNwEqHNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=i7p8PtwO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686f5so513330a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732030181; x=1732634981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUOWqpyC0v1hfZq0YqQxl/R5gZipGA6Ln5Fcfw4sWKg=;
        b=i7p8PtwOm+bsEpH4EyNnUY4ms/C3VVCgrdGGUpJvUn3KFmDmDqOPR1O45aIAp/Pbi/
         /LQNAxoZrHO4inUr0jQd2++TyQGfk6Tq+eZ8HNeWCRmNZb6HHXCp2gLQOyRFumkzKupw
         eR4AdOmpl3/CBF0Iw14l0CZdBgvmUeEJLQOogUAkqY4Uiue60h7XdNIFYjlIl77dTRKD
         6LzM0MQhIzrL8/MoyksQQu1k+gOCYB7w8Vr/7ei5KApdCPCYK/v7mKMAeyPLUC6GyIH0
         0epp0LCF0rHce9gS7lmb5NSzYh2WrSuAAXHVnwNYdcVauoy/RbdHmhV9KodhPrvTB0TD
         JnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030181; x=1732634981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUOWqpyC0v1hfZq0YqQxl/R5gZipGA6Ln5Fcfw4sWKg=;
        b=fsYjyaY1mIqwGE0b7xPL0YJ5anykwl0FQ7FsJWouVK1uLbdp5ZfZhlKYAnkEhKCgL2
         zoHTAiB84FLab49g1oI37+D0b4SFHbcEvEaRoQCMIMA1qM/AJjBZYz2iy5HTvkts31V+
         LTKB8DrdI/kip2rMXylrgEx18OUe0a2GXIkCLLbJYVTOgUZbfq1EnCRZwpSMEHATsCvk
         nUv2Y+AhlrH/S8O+ewrQBASUoCRceDelWpeZRhxbIFLBIiqOfi3a6z2JM9K8oXtd/rg8
         rrqaGbs26O4cU3VHRw4icum4v5BscOKf0XUXXCLEM+eGv85Vhr4/bnoEquFzoynCHbzs
         0hqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS3kbgsKijldLR3looW6ANh+BNRVrxAkOBpV/Wi5wvXGlKINl9OIR1NuijeywmiylEbwkTl6SIEjFCST0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/re94SBqk8V6JHP/NcJrBe5JmNo6wBXtC70eA+UJCkGlEFran
	048SYNS/C0y/Q8n5DOpGBEggOtH+bJrXgFdSnCkoMTIoAvRkTFHFX3i5x9boQno=
X-Google-Smtp-Source: AGHT+IEHNbIpE38/rJSisMVcTuCCnhgNxgoj9sUd03tfIU94+x34eL00MJr8o4ZWOw16GrURedp+gg==
X-Received: by 2002:a17:907:2d90:b0:aa4:8186:5a58 with SMTP id a640c23a62f3a-aa48344d225mr604014366b.8.1732030181167;
        Tue, 19 Nov 2024 07:29:41 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:141f:2700:f5a7:4035:a697:97ab])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26d6fsm659164366b.17.2024.11.19.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:29:40 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: yukuai1@huaweicloud.com
Cc: jinpu.wang@ionos.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	song@kernel.org,
	xni@redhat.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	yukuai3@huawei.com
Subject: RE:  [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector() 
Date: Tue, 19 Nov 2024 16:29:39 +0100
Message-ID: <20241119152939.158819-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adf796b9-2443-d29a-f4ac-fb9b8a657f93@huaweicloud.com>
References: <adf796b9-2443-d29a-f4ac-fb9b8a657f93@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuai,

We will test on our side and report back.

Yes, I meant patch5.

Regards!
Jinpu Wang @ IONOS


