Return-Path: <linux-kernel+bounces-542391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F6A4C993
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B593B9F17
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEA230277;
	Mon,  3 Mar 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OJOIaP0V"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE82661B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020939; cv=none; b=RcdDnTsTXHt2jbYhr/Nuv0iPOnlg9jz1K5n3oXzYnn1QUPQH/OvaRRLh32XdrvuXVRF0LxfZ47T+zzu9Sz/VG3JNIasaN7K7T0MBnhEUpMwmqKMtRzA13Jo8oxqV03fpdhQPBYD/zIu3dAvPN85VMcflWwwfQWQAL1NZzBRKrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020939; c=relaxed/simple;
	bh=UH4NlzYBkkWgbKnndkALjc2/BnPKdAhK1NZQa5X3WkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2qLxsJdbVzug1p9a7JR1zXrUGZc2W2gs6kp1quzAjOzenmsquZt5S57xbdphQn+LbV/MgCy6iXkDs4byGmOo6gJtaOzLIStrSMSf3Dw3tZLyALNtjays6pGqkZU0HjrRVn9u/axYLB7qCfeDSp44z4eOua8SdXTKCS1KeUT0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OJOIaP0V; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f16f4b73so45413691cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741020937; x=1741625737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=OJOIaP0Vxe+u3W1PRLYO3rpVYvJuxpJB+ajjqUENSzTHaKhQY/79ZSK60XQ/Ym5Iwr
         uv7jQ5EtJNoQM8qIX+d4ctGDZgF6DUdlSpIHqtuuYF9sdOEMOaDwNuoDtF6zlK4UNOQb
         onhd3/UeANnsLKxfjXp9PHUuv1T+0O8VVSxbDlX1w1Xqv/OY3UgDYNTnuhmdu9tZta8K
         bB1oyhYeOafYttdLjsKm6bO1rTDMSSWtfdGb6hTTc5dp4RJ72sbU6K5AMZ6rlH04iXQy
         hOVdcGkZGNecpwVkPDSV439RqyEmbuQzMmHKZ6W/JvkiPeCYDiHAbdXSRLtG1Uh/6tYk
         VOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020937; x=1741625737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJqDa+ZdsMQ9ydSfsBA3qoRWbBlsc9jKdUugmc9+LO4=;
        b=UXm8O4zil7YjgEZ18oqt8y7k9FU8IcrX+61BG7r/Aomde61EFo1yWQfHJuusoD8Cgh
         hbT5B7r301f3gG2rovX0siF0JDIoVkln1exbAgQJIipqZ9TlRqO7ZE2JR8c/Agjpo+XV
         SmfK3rdSa04/2Rm6UtDBJcqQrfVh3cwIVjGce6Ivffp8bd/ehmoVve9AleDGBUsA9QBY
         9E8lYbE1YNbPnm06GyFIZnqJtLaPheaULLwKZam6YQ3dV1QGYxfgNnzx8xiv9BbJca6k
         7L947h4pwMtxe+vjisXSQwfG88L9iVFViN54ixk9aBgwbXcF+cZj7UzqKc52Y4OQ6ZJU
         4HQg==
X-Forwarded-Encrypted: i=1; AJvYcCWDEzUcOKXTBjtCL4j0gHK/NAvFkzcjz+dPl/DzIKALA//aSTFW0phrDgANGB5wZ+HEVf58uq1EmBF4nLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyI7lzHfK1h9yQL+NO/K8YnhroUBK/ykQABPLOSHLR4medVEhY
	/V+HzQavMGsOnH1aPwcttel45ZZQsJ8xjiY0juIhUNdlTzu1rMltD1ICBw77Okg=
X-Gm-Gg: ASbGncs1gcyNkxtoTBH+9bf3XZByOsloJQt/LosISICrrYhWAuWmRC1vmlOWA0lU7nB
	kqda/vwpyWIrESFU9yKCYJCHPZNGtmLh6vcBnP+sS+Ll1qXAM200+91P6SzL9SLQ6tpwK1VIf3N
	x6zfJKLimusfeLxs7kGcYJa13pAFmLVJ23iN2tcdnmAXVd/aZR8iM6GokLDOYe4QQrmnDYIKAhl
	Ao0WKuCfLhn3WmEZdiCkSaFqNNcwStVsGpjiJJVaSqFm11ANj8sISiBeU0SHuFB+ok0A4+w5kFh
	+HTbwLsaUGARAZS/zFF283rrtqvPuwv06DkuKXWo7ExuLgpDvHPyDVf6gVBoYH4Nc7lvjihS2hW
	O/6Gxlef90yLSA1c9RQ==
X-Google-Smtp-Source: AGHT+IG3i30Vik/hq07e5CV5t54ZLHhq9hBAl2BnifWRWrXSNf/6v99OiWRFpkGkprdx8XpLFqILeA==
X-Received: by 2002:a05:622a:22a4:b0:474:d12f:2f3f with SMTP id d75a77b69052e-474d12f3287mr114169491cf.51.1741020936660;
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474dc59d291sm20118051cf.40.2025.03.03.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:55:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tp94p-00000000olC-0YQE;
	Mon, 03 Mar 2025 12:55:35 -0400
Date: Mon, 3 Mar 2025 12:55:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org,
	peterhuewe@gmx.de, sudeep.holla@arm.com, rafael@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add support for the TPM FF-A start method
Message-ID: <20250303165535.GT5011@ziepe.ca>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
 <Z8SypwnbJR4g8Bho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8SypwnbJR4g8Bho@kernel.org>

On Sun, Mar 02, 2025 at 09:33:59PM +0200, Jarkko Sakkinen wrote:
> WARNING: line length of 102 exceeds 100 columns
> #764: FILE: drivers/char/tpm/tpm_crb.c:821:
> +                               FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",

Just ignore that, it is an error in checkpatch. Strings are required to
be long. I suspect FW_BUG confused it.

Jason

