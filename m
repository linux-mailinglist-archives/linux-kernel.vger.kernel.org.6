Return-Path: <linux-kernel+bounces-443479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9E9EF22D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78958174B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182632288C0;
	Thu, 12 Dec 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7O5RU96"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A922EA0F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020998; cv=none; b=rGj/cqEfIg18Eavlz+oFUE8ACeOjnys5fXyVl2neJV68ieLFS1KQS3WURah+Q9YJDtSqleKcO8L6gN5Dvac9zzDSGpwl/EhYr27GxzRUsF2rmaWnD9/S32SLFcboz5Al9xGBauFo1u6wjiCISEFdQxRRKaLHKd53npo4DvYFSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020998; c=relaxed/simple;
	bh=gWB0BRFebjk00pC71MJN03tHjsq+//flbOeVjL0eWzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=FwOqg/Hwd8taPjkYOwT3xhbnbSz2Z6IY8xRldTyFpT99n7dxOwpzYU07inhAPItNViVV/aydF/h+3J7s4pgtLu4BOE3816fp0Hfm943q9LdjhspbmW+bDPFlDRfMouYDHHf90aUBHAQ/WY03cuZcvnQWQ4ydga36EVgTEAbyv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7O5RU96; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f26c517979so6086097b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020996; x=1734625796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEKKU4f34dN8LXHWBVKUE3kcH8a2Htoh1juEAfVgWR0=;
        b=W7O5RU96fefaWLzwkMtvwQdVvIiEYMn/3BFp4ZKh3IlYPdAKJHxwRokJqvHVh5vjOF
         opJrL7olE8df8sIUtvUdVvAooHkcwUz6KX/DQJ06Kxo9XzcRnjmW8XMmTvl0oJDIijwq
         N+CGw+/EzDfviEeSsYYSJqK28tIZgDlJKICF2+yJC7eZC08p6ckj8fdDNSEpxjPweSSB
         ZxQxOQ2/rugb0RbMY/4nxPW+hTn898JTwvPTMwPmJCMD7nW8pznIB7FYz2BEbRlsGBWC
         /5NL0JXSipMUtGKCmLdzE25+yLVlhEmDIT2wRI9XkQHKxdJ6ydqwpWY/zFFAzs1DVXla
         PgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020996; x=1734625796;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEKKU4f34dN8LXHWBVKUE3kcH8a2Htoh1juEAfVgWR0=;
        b=YFPEKMkRf46nCal1PaV9ja840LymYaKPeqUq1e33ZO1KqIDv04L+YtxRB5zKoAmRBd
         k+gwpUZDOnfmoAPtUtsPn7+2AghDfl5OHTz352XaLLe6lgu8kcMw2wmu5DCqzbORhTlO
         mR0ISlWvD8FbUio04dtU7H/rO6C1SBFlkCMCXG7oD0qbLgVo3v9EZ+2uqu/NBIUzjXEh
         09lpGbuNjEQK1+CkPmv1SVde4QdI25ejznNN5Ffuhkc9fVor56BH6yY+DZUuxxp0xT+x
         Gt0Bhk8JlDt5z9SgpnEQNwSbrq/F8g6ZKU5nCp+HPq0pctiDRFRaEMIxNT5Sg67J+CzN
         M6rw==
X-Forwarded-Encrypted: i=1; AJvYcCWEnbJg5J5nDHaOS2kExILpmwdD2rCbofcqWGj2VxQYJG7YAn3VGS+7t6kujm8Jgi9ENI6rVLFNqp0d05Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKsoSQPVMZvFGzLJ6Hs9PIRzWqPzmXfb3NMMMKPnzPsyA/uUm
	h90b1nOBNfEllPxgN9MWFnlF25aOJxcV7MzzWzwmNXMCZ23L5RD/4FhzclJRlyrAeAqA4W4Ga3W
	NstKB0eUafSDp670wZ3J5AfRLh7wZM7FvAB8=
X-Gm-Gg: ASbGncvkptvBKptxAdUa1ujGpMM4Th5CnKDmkdVYGZrtoJUAL47xdU/llwmNT3rH0xH
	8qEeSJuZak5c4YATzsg0DDZNiFxCH75To+jQXRYY=
X-Received: by 2002:a05:690c:6903:b0:6ef:9e74:c09b with SMTP id
 00721157ae682-6f27534f4c5mt11112017b3.33.1734020995845; Thu, 12 Dec 2024
 08:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212162547.225880-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20241212162547.225880-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 12 Dec 2024 17:29:19 +0100
Message-ID: <CAAEEuhrgqa+qDzr6O-FR8XYUHm05h2Nd4HG7=XVt9u7zqQm3yA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Replace magic number "6" by PCI_STD_NUM_BARS
Cc: rick.wertenbroek@heig-vd.ch, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:25=E2=80=AFPM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
> include/uapi/linux/pci_regs.h:
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  include/linux/pci-epf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 18a3aeb62ae4..ee6156bcbbd0 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -157,7 +157,7 @@ struct pci_epf {
>         struct device           dev;
>         const char              *name;
>         struct pci_epf_header   *header;
> -       struct pci_epf_bar      bar[6];
> +       struct pci_epf_bar      bar[PCI_STD_NUM_BARS];
>         u8                      msi_interrupts;
>         u16                     msix_interrupts;
>         u8                      func_no;
> @@ -174,7 +174,7 @@ struct pci_epf {
>         /* Below members are to attach secondary EPC to an endpoint funct=
ion */
>         struct pci_epc          *sec_epc;
>         struct list_head        sec_epc_list;
> -       struct pci_epf_bar      sec_epc_bar[6];
> +       struct pci_epf_bar      sec_epc_bar[PCI_STD_NUM_BARS];
>         u8                      sec_epc_func_no;
>         struct config_group     *group;
>         unsigned int            is_bound;
> --
> 2.25.1
>

The commit message was supposed to state :

---

PCI: endpoint: Replace magic number "6" by PCI_STD_NUM_BARS

Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
include/uapi/linux/pci_regs.h:
#define PCI_STD_NUM_BARS       6       /* Number of standard BARs */

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

---

But the line starting with # got eaten away as a comment.
Sorry about that.
Best regards,
Rick

