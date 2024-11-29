Return-Path: <linux-kernel+bounces-425743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D6E9DEA11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E726163ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CCC19F487;
	Fri, 29 Nov 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNAKcAA4"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241819CC1C;
	Fri, 29 Nov 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895945; cv=none; b=T1eMMNjbEhYe27w1c/p/ON8xyTdr59tCy5J78OY2TFu/9U6ssmL3t6etO+pqLZbgQzhV6rzO6aKWV1UE8JR45OgCLWeC2FUGvHR9zXKGgzbp8wVUXIAge6s3D9rhpEK0PYmvYl2RgRm2n7ZUrB5tMNxeta2FORTDo4gQIM9YoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895945; c=relaxed/simple;
	bh=tjg83BcvLm72RhXJ8aW40wzUz9Z+AXKuF8XiSPp7iRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOUdxm4T43M3kw8heJQ1zRIm7lQYuo66YTsQBB83V0f4CHjra3iKBNzgvxbJ1RBZDQ1V9AQdOYp80yvNgt0AE909wnHYw6wpjGrWbzGdKHNKHlKZZmsd84uwF2oqPsH/x+jPRNKZlpzDf1PhJVO1Raf/KqSVt3r5pVaO9u1RtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNAKcAA4; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f1d2487b95so711725eaf.0;
        Fri, 29 Nov 2024 07:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895942; x=1733500742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxstQK7lyLA1KAwlanh+JmMhzwB3UYAIFtRwg9zsVYQ=;
        b=LNAKcAA4Q8Vs8GTHJb/i8fkF5jDLyO+odBzMnOSYViRYWM9hX3fAWJ6QEBevturULd
         gAlou/LpkIp/surOsqcTqYS+pzJtLVU+WbHMKzMz3/0zfFM/iDZo0NiUCl+RWn2cdR+9
         VDyMTGaf2pC1q4RAwyM1Ofw6+hwWfsXZ4dUz5vkmKEO7+M+dTd8/3rkNiaQ2U6o2L1j8
         T99vtOTSVQ0CdwgR5kjcSlErebKFUGSwJOvqHwqS5oOdL3gWSGAmVlPlo4kYchw90FDN
         6XJRlerBflc6VM06EgbYgiacesUDUma3DMQBEiwfXcTB5nnvymeh6rDC5GCeNIjsQhte
         R7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895942; x=1733500742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxstQK7lyLA1KAwlanh+JmMhzwB3UYAIFtRwg9zsVYQ=;
        b=oA4M5k3oQ666Xe5Xyd4p1AoAe7nRpRnPR3MGjxtvHtHOugICKi2iNSGxIpt8x9bfW5
         ZGFFnO66deRaKFQAe/9OELAPWSM467QmMOxb4uh3qblbfQyhfy1o9ETLpiPqDqyrR9n6
         doRqNglVldM80Zi6ZhTdvGxsK3mlyOZk/vpnK1vUWy2dhgYscMHbXrK407Uo6ExwLdEj
         gsv0WOVFWtqN2dj3CxapWNXZq/+dyQR4y63tad0zSgPk97bvoSd661Kks/rjcFENGY4G
         qXFPc6soxASSeiLRhoig3KKjI/Q/sWKEqXihZKKw7mh2N/I3B6wEPSd8N49sxYvoNyX3
         ro1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSfwg4d1+LxdbffD9cmePKn/2IC0hZ058K7sWdPhrYF+bJzm8GigX7UiHiBqsOoN2Vf7awClUWT24xsmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XCvc05rv95yBCW2vLYblFQYWMHqC4fFpEsIWGm/J2J0GdUPR
	jwvZFJC5aMBOSJKJvJXVbKhZxg9r35tLU+ihx3X2KeQnjy5gjLEm
X-Gm-Gg: ASbGncvK/m/dzwc/3yQ3Fz+QNuC+G/Tcjabej9RSNFx1Vw8iw5CWKHk5upa+wXp9Q50
	BUoDhMeg0ZMCpvLXJCnDY/GsXqWIr3g4GXI3IZNbLywDb5IYbl6yeg9s7NiBkiAe1/F52K3YW0j
	yX+dMdrudAT5RP3VzWDF6HF1ZGArHnibKKBsLqMGOKZ5K2AZQtv9RXVIYiHNjaMfKE5Mo50KFoD
	K1edK/rHl+NPgmQTbJwy+XTEo52T9vWiCmbZPc6/bo3AT7sljidKC0gYJfT81qA7U/tCVUvKitd
X-Google-Smtp-Source: AGHT+IHSP4Koh9Y9mkSlcHToCXZivn+5KiUUo3WQY+jr+CS7AKVG2i+lvkc3J8jHXcv0v0GTO3NldA==
X-Received: by 2002:a05:6820:823:b0:5e1:ea03:9286 with SMTP id 006d021491bc7-5f20a1e15edmr7969019eaf.6.1732895942287;
        Fri, 29 Nov 2024 07:59:02 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:59:01 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 5/7] docs/sp_SP: Add translation of process/7.AdvancedTopics.rst
Date: Fri, 29 Nov 2024 09:58:45 -0600
Message-ID: <20241129155851.1023884-6-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
References: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Avadhut Naik <avadhut.naik@amd.com>

Translate Documentation/process/7.AdvancedTopics.rst into Spanish.

Co-developed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../sp_SP/process/7.AdvancedTopics.rst        | 207 +++++++++++++++++-
 .../sp_SP/process/development-process.rst     |   1 +
 2 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst b/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
index 553759857339..42cb8b866e11 100644
--- a/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
@@ -1,11 +1,214 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/7.AdvancedTopics.rst
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_advancedtopics:
 
 Temas avanzados
 ===============
 
-.. warning::
-	TODO aún no traducido
+Llegados a este punto, con suerte, tiene una idea de cómo funciona el
+proceso de desarrollo. Sin embargo, ¡todavía hay más que aprender! Esta
+sección cubrirá varios temas que pueden ser útiles para los desarrolladores
+que desean convertirse en una parte regular del proceso de desarrollo del
+kernel Linux.
+
+Gestionar parches con git
+-------------------------
+
+El uso del control de versiones distribuido para el kernel comenzó a
+principios de 2002 cuando Linus comenzó a jugar con la aplicación
+propietaria BitKeeper. Aunque BitKeeper fue controvertido, el enfoque de
+la gestión de versiones de software que incorporó ciertamente no lo fue.
+El control de versiones distribuido permitió una aceleración inmediata
+del proyecto de desarrollo del kernel. En los tiempos actuales, existen
+varias alternativas gratuitas a BitKeeper. Para bien o para mal, el
+proyecto del kernel ha optado por git como su herramienta preferida.
+
+Administrar parches con git puede hacer la vida mucho más fácil para el
+desarrollador, especialmente a medida que crece el volumen de esos
+parches. Git también tiene sus asperezas y representa ciertos peligros;
+es una herramienta joven y poderosa que aún está siendo civilizada por
+sus desarrolladores. Este documento no intentará enseñar al lector cómo
+usar git; eso sería material suficiente para un documento extenso por
+derecho propio. En su lugar, el enfoque aquí será cómo git encaja en el
+proceso de desarrollo del kernel en particular. Los desarrolladores que
+deseen ponerse al día con git encontrarán más información en:
+
+	https://git-scm.com/
+
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+
+y en varios tutoriales que se encuentran en la web.
+
+El primer orden del negocio es leer los sitios mencionados anteriormente
+y comprender cómo funciona git antes de intentar usarlo para poner
+parches a disposición de otros. Un desarrollador que usa git debe ser
+capaz de obtener una copia del repositorio mainline, explorar el historial
+de revisiones, hacer commits en el árbol, usar ramas, etcétera. También es
+útil entender las herramientas de git para rescribir la historia (como
+rebase). Git viene con su propia terminología y conceptos; un nuevo
+usuario de git debe conocer las referencias, las ramas remotas, el índice,
+las fusiones fast-forward, los pushes y pulls, las cabezas separadas,
+etcétera. Todo puede ser un poco intimidante al principio, pero los
+conceptos no son tan difíciles de entender con un poco de estudio.
+
+Usar git para generar parches para enviarlos por correo electrónico puede
+ser un buen ejercicio mientras te pones al día.
+
+Cuando esté listo para comenzar a publicar árboles de git para que otros
+los vean, necesitará por supuesto, un servidor del que se pueda extraer.
+Configurar un servidor de este tipo con git-daemon es relativamente
+sencillo si tiene un sistema accesible a Internet. De lo contrario, los
+sitios de alojamiento público y gratuitos (GitHub, por ejemplo) están
+comenzando a aparecer en la red. Los desarrolladores establecidos pueden
+obtener una cuenta en kernel.org, pero no son fáciles de conseguir; ver
+https://kernel.org/faq/ para más información.
+
+El flujo de trabajo normal de git implica el uso de muchas ramas. Cada
+línea de desarrollo puede separarse en una “rama temática” separada y
+mantenerse de forma independiente. Las ramas en git son baratas, no hay
+razón para no hacer uso gratuito de ellas. Y, en cualquier caso, no debe
+desarrollarse en ninguna rama de la que tenga la intención de pedir a
+otros que hagan un pull. Las ramas disponibles públicamente deben crearse
+con cuidado; fusione los parches de las ramas de desarrollo cuando estén
+en forma completa y listos para usar – no antes.
+
+Git proporciona herramientas poderosas que permiten reescribir su historia
+de desarrollo. Un parche inconveniente (uno que rompe la bisección, por
+ejemplo, o que tiene algún otro tipo de error obvio) se puede corregir en
+su lugar o hacer que desaparezca de la historia por completo. Una serie de
+parches se puede reescribir como si se hubiera escrito sobre el mainline
+de hoy, aunque haya estado trabajando en ella durante meses. Los cambios
+se pueden transferir de manera transparente de una rama a otra. Y así
+sucesivamente. El uso juicioso de la capacidad de git para revisar el
+historial puede ayudar en la creación de conjuntos de parches limpios con
+menos problemas.
+
+El uso excesivo de esta capacidad puede llevar a otros problemas más allá
+de una simple obsesión por crear la historia perfecta del proyecto.
+Reescribir la historia rescribirá los cambios contenidos en esa historia,
+convirtiendo un árbol del kernel probado (con suerte) en uno no probado.
+Pero más allá de eso, los desarrolladores no pueden colaborar fácilmente
+si no tienen una vista compartida del historial del proyecto; si reescribe
+la historia que otros desarrolladores han introducido en sus repositorios,
+les hará la vida mucho más difícil a esos desarrolladores. Por lo tanto,
+aquí se aplica una regla simple general: la historia que se ha exportado
+a otros generalmente debe considerarse inmutable a partir de entonces.
+
+Por lo tanto, una vez que envié un conjunto de cambios a su servidor
+disponible públicamente, esos cambios no deben reescribirse. Git
+intentará hacer cumplir esta regla si intenta enviar cambios que no
+resulten en un “fast-forward merge” (es decir, cambios que no comparten
+el mismo historial). Es posible anular esta comprobación, y puede haber
+ocasiones en las que sea necesario reescribir un árbol exportado. Mover
+conjuntos de cambios entre árboles para evitar conflictos en linux-next
+es un ejemplo. Pero tales acciones deberían ser raras. Esta es una de las
+razones por las que el desarrollo debe hacerse en ramas privadas (que se
+pueden reescribir si es necesario) y solo trasladarse a ramas públicas
+cuando esté en un estado razonablemente avanzado.
+
+A medida que el mainline (u otro árbol en el que se basa un conjunto de
+cambios) avanza, es tentador fusionarse con ese árbol para permanecer a
+la vanguardia. Para una rama privada, la rebase puede ser una manera fácil
+de mantenerse al día con otro árbol, pero la rebase no es una opción una
+vez que el árbol se exporta al mundo. Una vez que eso sucede, se debe
+realizar una fusión completa. Fusionar ocasionalmente tiene sentido, pero
+las fusiones demasiado frecuentes pueden desordenar el historial
+innecesariamente. La técnica sugerida en este caso es fusionar con poca
+frecuencia y, por lo general, solo en puntos de lanzamiento específicos
+(como una versión -rc del mainline). Si está nervioso por cambios
+específicos, siempre puede realizar fusiones de prueba en una rama
+privada. La herramienta git “rerere” puede ser útil en tales situaciones;
+recuerda cómo se resolvieron los conflictos de fusión para que no tenga
+que hacer el mismo trabajo dos veces.
+
+Una de las mayores quejas recurrentes sobre herramientas como git es la
+siguiente: el movimiento masivo de parches de un repositorio a otro hace
+que sea fácil deslizar cambios más aconsejados que pasan al mainline
+debajo del radar de revisión. Los desarrolladores del kernel tienden a
+descontentarse cuando ven que suceden ese tipo de cosas; poner un árbol
+de git con parches no revisados o fuera de tema puede afectar su capacidad
+para hacer que los árboles sean integrados en el futuro. Citando a Linus:
+
+::
+
+	Puede enviarme parches, pero para que yo acepte un parche de git de
+	su parte, necesito saber que usted sabe lo que está haciendo, y
+	necesito poder confiar en las cosas *sin* tener que revisar
+	manualmente cada cambio individual.
+
+(https://lwn.net/Articles/224135/).
+
+Para evitar este tipo de situación, asegúrese de que todos los parches
+dentro de una rama determinada se adhieran estrictamente al tema asociado;
+una rama de “correcciones de drivers” no debería hacer cambios en el
+código central de gestión de memoria. Y, lo más importante, no utilice un
+árbol git para eludir el proceso de revisión. Publique un resumen
+ocasional del árbol en la lista relevante y, cuando sea el momento
+adecuado, solicite que el árbol se incluya en linux-next.
+
+Si y cuando otros comiencen a enviar parches para su inclusión en su
+árbol, no olvide revisarlos. Además, asegúrese de mantener la información
+de autoría correcta; la herramienta git “am” hace lo mejor que puede es
+este sentido, pero es posible que tenga que agregar una línea “From:” al
+parche si ha sido reenviado a través de un tercero.
+
+Al solicitar un pull, proporcione toda la información relevante: dónde
+está su árbol, qué rama se debe pull, y que cambios resultarán del pull.
+El comando git request-pull puede ser útil en este sentido; formateará la
+solicitud como otros desarrolladores esperan, y también comprobará para
+asegurarse de que ha recordado enviar esos cambios al servidor público.
+
+Revisión de parches
+-------------------
+
+Algunos lectores seguramente se opondrán a incluir esta sección con
+“temas avanzados” porque incluso los desarrolladores principiantes del
+kernel deberían revisar los parches. Es cierto que no hay mejor manera de
+aprender a programar en el entorno del kernel que mirando el código
+publicado por otros. Además, los revisores siempre escasean; al revisar
+código, puede contribuir significativamente al proceso en su conjunto.
+
+Revisar el código puede ser una perspectiva intimidante, especialmente
+para un nuevo desarrollador de kernel que puede sentirse nervioso al
+cuestionar el código – en público – publicado por aquellos con más
+experiencia. Sin embargo, incluso el código escrito por los desarrolladores
+más experimentados se puede mejorar. Quizás el mejor consejo para los
+revisores (todos los revisores) es este: expresar los comentarios de
+revisión como preguntas en lugar de críticas. Preguntar “¿cómo se libera
+el bloqueo en este camino?” siempre funcionará mejor que decir “el
+bloqueo aquí es incorrecto”.
+
+Otra técnica que es útil en caso de desacuerdo es pedir a otros que
+intervengan. Si una discusión llega a un punto muerto después de algunos
+intercambios, solicite las opiniones de otros revisores o maintainers. A
+menudo, aquellos que están de acuerdo con un revisor permanecen en
+silencio a menos que se les invite a participar. La opinión de varias
+personas tiene exponencialmente más peso.
+
+Diferentes desarrolladores revisarán el código desde diferentes puntos de
+vista. Algunos se preocupan principalmente por el estilo de codificación
+y si las líneas de código tienen espacios en blanco al final. Otros se
+enfocarán principalmente en si el cambio implementado por el parche en su
+totalidad es beneficioso para el kernel o no. Sin embargo, otros
+comprobarán si hay bloqueos problemáticos, uso excesivo de la pila,
+posibles problemas de seguridad, duplicación de código encontrado en
+otras partes, documentación adecuada, efectos adversos en el rendimiento,
+cambios en la ABI del espacio de usuario, etcétera. Todos los tipos de
+revisión, si conducen a un mejor código en el kernel, son bienvenidos y
+valen la pena.
+
+No hay ningún requisito estricto para usar etiquetas específicas como
+``Reviewed-by``. De hecho, las revisiones en Inglés sencillo son más
+informativas y alentadas incluso cuando se proporciona una etiqueta, por
+ejemplo, “Revisé los aspectos A, B y C de esta propuesta y me parece
+bien”.
+¡Alguna forma de mensaje de revisión o respuesta es obviamente necesaria,
+de lo contrario, los maintainers no sabrán que el revisor ha revisado el
+parche en absoluto!
+
+Por último, pero no menos importante, la revisión de parches puede
+convertirse en un proceso negativo, centrado en señalar problemas. ¡Por
+favor, dé un cumplido de vez en cuando, especialmente a los principiantes!
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index c977d047a792..ecfa04d96b5e 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -29,3 +29,4 @@ para entenderla.
    4.Coding
    5.Posting
    6.Followthrough
+   7.AdvancedTopics
-- 
2.43.0


